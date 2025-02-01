import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:qbittorrent_client/models/added_torrent_settings.dart';
import 'package:qbittorrent_client/models/file_info.dart';
import 'package:qbittorrent_client/models/torrent_info.dart';
import 'package:qbittorrent_client/repositories/local_storage_repository.dart';

import 'utils.dart';

class QbittorrentWebApi {
  QbittorrentWebApi({required this.dio});

  static const String _keyAddress = 'address';
  static const String _keyPort = 'port';
  static const String _keyHttps = 'https';

  // Endpoints
  static const String _endpointLogin = "api/v2/auth/login";
  static const String _endpointTorrentsInfo = "api/v2/torrents/info";
  static const String _endpointTorrentsPause = "api/v2/torrents/stop";
  static const String _endpointTorrentsResume = "api/v2/torrents/start";
  static const String _endpointTorrentFiles = "api/v2/torrents/files";
  static const String _endpointTorrentDelete = "api/v2/torrents/delete";
  static const String _endpointTorrentAdd = "api/v2/torrents/add";
  static const String _endpointTorrentFilePrio = "api/v2/torrents/filePrio";


  String? _sid;
  String? _baseUrl;

  final Dio dio;

  /// Constructs the base URL for the API.
  String _buildBaseUrl(String address, bool useHttps, String port) {
    final protocol = useHttps ? 'https' : 'http';
    return '$protocol://$address:$port';
  }

  Future<bool> tryRestoreSession() async {

    final address = await GetIt.I.get<LocalStorageRepository>().getString(_keyAddress);
    final port = await GetIt.I.get<LocalStorageRepository>().getString(_keyPort);
    final useHttps = await GetIt.I.get<LocalStorageRepository>().getBool(_keyHttps);

    if(address == null || port == null || useHttps == null) {
      return false;
    }

    _baseUrl = _buildBaseUrl(address, useHttps, port);
    if(_baseUrl == null || _baseUrl!.isEmpty) {
      return false;
    }

    final sidFromStorage = await GetIt.I.get<LocalStorageRepository>().getString('sid');

    if(sidFromStorage == null) {
      return false;
    }

    final bool test = await checkSession(sidFromStorage);

    if(test == false) {
      _sid = null;
      await GetIt.I.get<LocalStorageRepository>().saveString('sid', "");

      return false;
    }
    else
    {
      return true;
    }
    return false;
  }

  Future<bool> checkSession(String sid) async {
    _sid = sid;
    final test = await getTorrentsList();

    if(test == null || test.isEmpty)
    {
      _sid = null;
      return false;
    }
    else
    {
      return true;
    }
  }

  /// Logs in and retrieves the session ID (SID).
  Future<bool> tryLogin({
    required String address,
    required String port,
    required bool https,
    required String username,
    required String password,
  }) async {


    if(await tryRestoreSession()) {
      return true;
    }

    if (_sid != null) return true;

    _baseUrl = _buildBaseUrl(address, https, port);
    try {
      final response = await dio.post(
        '$_baseUrl/$_endpointLogin',
        data: {
          'username': username,
          'password': password,
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {'Referer': _baseUrl},
        ),
      );

      if (response.statusCode == 200) {
        final cookies = response.headers['set-cookie'];
        if (cookies != null && cookies.isNotEmpty) {
          _sid = extractSID(cookies.first);
          if (_sid != null) {
            await GetIt.I.get<LocalStorageRepository>().saveString('sid', _sid!);
            return true;
          }
        }
      }
      return false;
    } catch (e) {
      print('Login failed: $e');
      return false;
    }
  }

  /// Retrieves a list of torrents.
  Future<List<TorrentInfo>> getTorrentsList() async {
    try {
      final response = await dio.post(
        '$_baseUrl/$_endpointTorrentsInfo',
        options: _authHeaders(),
      );

      final data = response.data as List;
      //print(data);
      //data.toList().map((e) => print(e));
      return data.map((e) => TorrentInfo.fromJson(e)).toList();
    } catch (e) {
      print('Failed to fetch torrents list: $e');
      //throw e;
      return List.empty();
    }
  }

  /// Retrieves detailed information for a specific torrent.
  Future<TorrentInfo> getTorrentData(String hash) async {
    try {
      final response = await dio.post(
        '$_baseUrl/$_endpointTorrentsInfo',
        data: {'hashes': hash},
        options: _authHeaders(),
      );

      final data = response.data.first;
      return TorrentInfo.fromJson(data);
    } catch (e) {
      print('Failed to fetch torrent data: $e');
      rethrow;
    }
  }

  /// Starts specified torrents.
  Future<void> startTorrents(List<String> hashes) async {
    await _sendTorrentAction(_endpointTorrentsResume, hashes);
  }

  /// Pauses specified torrents.
  Future<void> stopTorrents(List<String> hashes) async {
    await _sendTorrentAction(_endpointTorrentsPause, hashes);
  }
  Future<void> deleteTorrents({required List<String> hashes, required bool deleteFiles}) async {
    try {
      await dio.post(
        '$_baseUrl/$_endpointTorrentDelete',
        data: {
          'hashes': convertHashesToString(hashes),
          'deleteFiles': deleteFiles.toString(),
        },
        options: _authHeaders(),
      );
    } catch (e) {
      print('Failed to perform action on torrents: $e');
      rethrow;
    }
  }


  /// Retrieves the list of files for a specific torrent.
  Future<List<FileInfo>> getTorrentFiles(String hash) async {
    try {
      final response = await dio.post(
        '$_baseUrl/$_endpointTorrentFiles',
        data: {'hash': hash},
        options: _authHeaders(),
      );

      final data = response.data as List;
      return data.map((e) => FileInfo.fromJson(e)).toList();
    } catch (e) {
      print('Failed to fetch torrent files: $e');
      rethrow;
    }
  }

  /// Helper to send actions to start/stop torrents.
  Future<void> _sendTorrentAction(String endpoint, List<String> hashes) async {
    try {
      await dio.post(
        '$_baseUrl/$endpoint',
        data: {'hashes': convertHashesToString(hashes)},
        options: _authHeaders(),
      );
    } catch (e) {
      print('Failed to perform action on torrents: $e');
      rethrow;
    }
  }
  Future<void> setFilePriority(String torrentHash, String fileId, int priority) async {
    try {
      await dio.post(
        '$_baseUrl/$_endpointTorrentFilePrio',
        data: {
          'hash': torrentHash, //convertHashesToString(hashes),
          'id': fileId,
          'priority': priority,

        },
        options: _authHeaders(),
      );
    } catch (e) {
      print('Failed to perform file priority on torrents: $e');
      rethrow;
    }
  }

  /// Uploads a `.torrent` file to the server.
  Future<void> uploadTorrentFile(
      AddedTorrentSettings torrentSetting) async {
    try {
      final file = await MultipartFile.fromFile(torrentSetting.filePath, filename: torrentSetting.filePath.split('/').last);
      final formData = FormData.fromMap({
        'torrents': file,
        'savepath': torrentSetting.savePath ?? '',
        //'category': category ?? '',
        'skip_checking': torrentSetting.skipChecking ?? '',
        //'paused': paused ?? '',
        'paused': torrentSetting.paused.toString(),
        'rename': torrentSetting.rename ?? '',

      });

      final response = await dio.post(
        '$_baseUrl/$_endpointTorrentAdd',
        data: formData,
        options: _authHeaders()
      );

      if (response.statusCode == 200) {
        print('Torrent file uploaded successfully.');
      } else {
        throw Exception('Failed to upload torrent file: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error uploading torrent file: $e');
      rethrow;
    }
  }

  /// Adds a Magnet link to the server.
  Future<void> uploadMagnetLink(String magnetLink, {String? savePath, bool paused = false}) async {
    try {
      final response = await dio.post(
        '$_baseUrl/$_endpointTorrentAdd',
        data: {
          'urls': magnetLink,
          'savepath': savePath ?? '',
          'paused': paused.toString(),
        },
        options: _authHeaders(),
      );

      if (response.statusCode == 200) {
        print('Magnet link added successfully.');
      } else {
        throw Exception('Failed to add Magnet link: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error uploading Magnet link: $e');
      rethrow;
    }
  }

  /// Constructs headers with authentication.
  Options _authHeaders() {
    if (_sid == null) {
      throw Exception('SID is null. Login is required.');
    }

    return Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {
        'Referer': _baseUrl,
        'Cookie': 'SID=$_sid',
      },
    );
  }

}
