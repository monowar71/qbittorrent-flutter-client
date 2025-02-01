import 'package:dio/dio.dart';

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
  static const String _endpointTorrentDelete = "api/v2/torrents/delete";
  static const String _endpointTorrentAdd = "api/v2/torrents/add";
  static const String _endpointTorrentFilePrio = "api/v2/torrents/filePrio";

  String _buildBaseUrl(String address, String port, bool isHTTPS) {
    final protocol = isHTTPS ? 'https' : 'http';
    return '$protocol://$address:$port';
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
      _sid = response.headers['set-cookie']?.first;
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<List<Map<String, dynamic>>> getTorrents() async {
    final response = await dio.get(
      '$baseUrl/api/v2/torrents/info',
      options: Options(headers: {'Cookie': _sid}),
    );

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(response.data);
    } else {
      throw Exception('Failed to load torrents');
    }
  }

  Future<void> addTorrent(String url) async {
    final response = await dio.post(
      '$baseUrl/api/v2/torrents/add',
      data: {'urls': url},
      options: Options(headers: {'Cookie': _sid}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add torrent');
    }
  }
}