import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:qbittorrent_client/qbittorrent_client_app.dart';
import 'package:qbittorrent_client/repositories/local_storage_repository.dart';
import 'package:qbittorrent_client/repositories/qbittorrent_web_api.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Инициализируем SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();

  // Регистрация зависимостей
  GetIt.I.registerLazySingleton(() => QbittorrentWebApi(dio: Dio()));
  GetIt.I.registerLazySingleton(
          () => LocalStorageRepository(sharedPreferences: sharedPreferences));


  runApp(QbittorrentClientApp());
}

