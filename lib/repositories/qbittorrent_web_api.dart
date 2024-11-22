import 'package:dio/dio.dart';
import 'package:qbittorrent_client/repositories/file_info.dart';
import 'package:qbittorrent_client/repositories/torrent_info.dart';

import 'utils.dart';

class QbittorrentWebApi {
  QbittorrentWebApi({required this.dio});

  // Endpoints
  static const String _endpointLogin = "api/v2/auth/login";
  static const String _endpointTorrentsInfo = "api/v2/torrents/info";
  static const String _endpointTorrentsPause = "api/v2/torrents/stop";
  static const String _endpointTorrentsResume = "api/v2/torrents/start";
  static const String _endpointTorrentFiles = "api/v2/torrents/files";
  static const String _endpointTorrentDelete = "api/v2/torrents/delete";
  static const String _endpointTorrentAdd = "api/v2/torrents/add";


  String? _sid;
  String? _baseUrl;

  final Dio dio;

  /// Constructs the base URL for the API.
  String _buildBaseUrl(String address, bool useHttps, String port) {
    final protocol = useHttps ? 'https' : 'http';
    return '$protocol://$address:$port';
  }

  /// Logs in and retrieves the session ID (SID).
  Future<bool> tryLogin({
    required String address,
    required String port,
    required bool https,
    required String username,
    required String password,
  }) async {
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
          if (_sid != null) return true;
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
      return data.map((e) => TorrentInfo.fromJson(e)).toList();
    } catch (e) {
      print('Failed to fetch torrents list: $e');
      rethrow;
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

  /// Uploads a `.torrent` file to the server.
  Future<void> uploadTorrentFile(String filePath, {String? savePath, bool paused = false}) async {
    try {
      final file = await MultipartFile.fromFile(filePath, filename: filePath.split('/').last);
      final formData = FormData.fromMap({
        'torrents': file,
        'savepath': savePath ?? '',
        'paused': paused.toString(),
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
