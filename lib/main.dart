import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:qbittorrent_client/qbittorrent_client_app.dart';
import 'package:qbittorrent_client/repositories/qbittorrent_web_api.dart';


void main() {
  GetIt.I.registerLazySingleton(() => QbittorrentWebApi(dio: Dio()));

  runApp(QbittorrentClientApp());
}

