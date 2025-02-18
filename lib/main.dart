import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:qbittorrent_client/api/auth_interceptor.dart';
import 'package:qbittorrent_client/i18n/strings.g.dart';
import 'package:qbittorrent_client/qbittorrent_client_app.dart';
import 'package:qbittorrent_client/repositories/local_storage_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/qbittorrent_api.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();

  GetIt.I.registerSingleton<Dio>(Dio());

  GetIt.I.registerLazySingleton(() =>
      LocalStorageRepository(sharedPreferences: sharedPreferences));

  GetIt.I.registerSingleton<QBittorrentApi>(QBittorrentApi(dio: GetIt.I.get<Dio>(),));

  LocaleSettings.useDeviceLocale();

  runApp(TranslationProvider(child: QbittorrentClientApp()));
}

