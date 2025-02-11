import 'package:dio/dio.dart';
import 'package:qbittorrent_client/models/added_torrent_settings.dart';
import 'package:qbittorrent_client/models/file_info.dart';
import 'package:qbittorrent_client/models/torrent_info.dart';
import 'package:qbittorrent_client/models/torrent_properties.dart';
import 'package:qbittorrent_client/utils.dart';

class QBittorrentApi {
  QBittorrentApi({required this.dio});

  final Dio dio;

  String? baseUrl;
  String? _sid;


  // Endpoints
  static const String _endpointLogin = "api/v2/auth/login";
  static const String _endpointTorrentsInfo = "api/v2/torrents/info";
  static const String _endpointTorrentsPause = "api/v2/torrents/stop";
  static const String _endpointTorrentsResume = "api/v2/torrents/start";
  static const String _endpointTorrentFiles = "api/v2/torrents/files";
  static const String _endpointTorrentProperties = "api/v2/torrents/properties";
  static const String _endpointTorrentDelete = "api/v2/torrents/delete";
  static const String _endpointTorrentAdd = "api/v2/torrents/add";
  static const String _endpointSetFilePriority = "api/v2/torrents/filePrio";
  static const String _endpointRenameFile = "api/v2/torrents/renameFile";

  String _buildBaseUrl(String address, String port, bool isHTTPS) {
    final protocol = isHTTPS ? 'https' : 'http';
    return '$protocol://$address:$port';
  }

  Options _authHeaders() {
    if (_sid == null) {
      throw Exception('SID is null. Login is required.');
    }

    return Options(
      contentType: Headers.formUrlEncodedContentType,
      headers: {
        'Referer': baseUrl,
        'Cookie': 'SID=$_sid',
      },
    );
  }

  Future<void> login({
    required String address,
    required String port,
    required bool isHTTPS,
    required String username,
    required String password,
  }) async {
    baseUrl = _buildBaseUrl(address, port, isHTTPS);

    final response = await dio.post(
      '$baseUrl/$_endpointLogin',
      data: {
        'username': username,
        'password': password,
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {'Referer': baseUrl},
      ),
    );

    if (response.statusCode == 200) {
      final cookies = response.headers['set-cookie'];
      if (cookies != null && cookies.isNotEmpty) {
        _sid = extractSID(cookies.first);
      }
      else {
        throw Exception('Failed to get sid');
      }
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<List<TorrentInfo>> getTorrentsList() async {
    final response = await dio.get(
      '$baseUrl/$_endpointTorrentsInfo',
      options: _authHeaders(),
    );

    if (response.statusCode == 200) {
      final data = response.data as List;
      return data.map((e) => TorrentInfo.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load torrents');
    }
  }

  Future<TorrentInfo> getTorrentData(String hash) async {
    final response = await dio.post(
      '$baseUrl/$_endpointTorrentsInfo',
      data: {'hashes': hash},
      options: _authHeaders(),
    );

    if (response.statusCode == 200) {
      final data = response.data.first;
      return TorrentInfo.fromJson(data);
    } else {
      throw Exception('Failed to load torrent data');
    }
  }

  Future<List<FileInfo>> getTorrentFiles(String hash) async {
    final response = await dio.post(
      '$baseUrl/$_endpointTorrentFiles',
      data: {'hash': hash},
      options: _authHeaders(),
    );
    if (response.statusCode == 200) {
      final data = response.data as List;
      return data.map((e) => FileInfo.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load torrent files');
    }
  }
  Future<TorrentProperties> getTorrentProperties(String hash) async {
    final response = await dio.post(
      '$baseUrl/$_endpointTorrentProperties',
      data: {'hash': hash},
      options: _authHeaders(),
    );
    if (response.statusCode == 200) {
      final data = response.data.first;
      return TorrentProperties.fromJson(data);
    }
    else {
      throw Exception('Failed to get torrent properties');
    }
  }

  Future<void> resumeTorrents(String hash) async {
    final response = await dio.post(
      '$baseUrl/$_endpointTorrentsResume',
      data: {'hashes': hash},
      options: _authHeaders(),
    );

    if (response.statusCode == 200) {}
    else {
      throw Exception('Failed to resume torrents');
    }
  }
  Future<void> pauseTorrents(String hash) async {
    final response = await dio.post(
      '$baseUrl/$_endpointTorrentsPause',
      data: {'hashes': hash},
      options: _authHeaders(),
    );

      if (response.statusCode == 200) {}
      else {
        throw Exception('Failed to pause torrents');
    }
  }
  Future<void> deleteTorrents(String hash, bool deleteFiles) async {
    final response = await dio.post(
      '$baseUrl/$_endpointTorrentDelete',
      data: {
        'hashes': hash,
        'deleteFiles': deleteFiles.toString()
        },
      options: _authHeaders(),
    );
    if (response.statusCode == 200) {}
    else {
      throw Exception('Failed to delete torrents');
    }
  }
  Future<void> uploadTorrentFile(AddedTorrentSettings torrentSetting) async {
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
        '$baseUrl/$_endpointTorrentAdd',
        data: formData,
        options: _authHeaders()
    );

    if (response.statusCode == 200) {}
    else {
      throw Exception('Failed to delete torrents');
    }
  }
  Future<void> renameFile(String hash, String oldPath, String newPath) async {
    final response = await dio.post(
      '$baseUrl/$_endpointRenameFile',
      data: {
        'hash': hash,
        'oldPath': oldPath,
        'newPath': newPath,
      },
      options: _authHeaders(),
    );

    if (response.statusCode == 200) {}
    else {
      throw Exception('Failed to Rename File');
    }
  }
  Future<void> setFilePriority(String hash, String fileId, int priority) async {
    final response = await dio.post(
      '$baseUrl/$_endpointSetFilePriority',
      data: {
        'hash': hash,
        'id': fileId,
        'priority': priority
      },
      options: _authHeaders(),
    );
    if (response.statusCode == 200) {}
    else {
      throw Exception('Failed to set file priority');
    }
  }
}