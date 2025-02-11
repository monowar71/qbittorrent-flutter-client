import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:qbittorrent_client/api/auth_interceptor.dart';
import 'package:qbittorrent_client/api/qbittorrent_api.dart';
import 'package:qbittorrent_client/bloc/add_torrent/add_torrent_bloc.dart';
import 'package:qbittorrent_client/bloc/auth/auth_bloc.dart';
import 'package:qbittorrent_client/bloc/torrent_file_info/torrent_file_info_bloc.dart';
import 'package:qbittorrent_client/bloc/torrents/torrents_bloc.dart';
import 'package:qbittorrent_client/i18n/strings.g.dart';
import 'package:qbittorrent_client/repositories/local_storage_repository.dart';
import 'package:qbittorrent_client/screens/add_torrent_screen/add_torrent_screen.dart';
import 'package:qbittorrent_client/screens/auth_screen/auth_screen.dart';
import 'package:qbittorrent_client/screens/torrent_card_screen/torrent_card_screen.dart';
import 'package:qbittorrent_client/screens/torrents_list_screen/torrents_list_screen.dart';

class QbittorrentClientApp extends StatelessWidget {

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final dio = GetIt.I<Dio>();
  final QBittorrentApi api = GetIt.I<QBittorrentApi>();
  final LocalStorageRepository localStorageRepository = GetIt.I<LocalStorageRepository>();

  QbittorrentClientApp({super.key});

  @override
  Widget build(BuildContext context) {
    dio.interceptors.add(AuthInterceptor(onUnauthorized: () {
      navigatorKey.currentState?.pushNamedAndRemoveUntil('/auth', (route) => false);
    }));

    return MaterialApp(
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: AppLocaleUtils.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      navigatorKey: navigatorKey,
      initialRoute: '/auth',
      routes: {
        '/auth': (context) => BlocProvider(
          create: (context) => AuthBloc(
            api: api,
            localStorageRepository: localStorageRepository),
          child: AuthScreen(),
        ),
        '/torrents': (context) => BlocProvider(
          create: (context) => TorrentsBloc(
              api: api),
          child: TorrentsListScreen(),
        ),
        '/torrent_info': (context) => MultiBlocProvider(providers: [
          BlocProvider(
              create: (context) => TorrentsBloc(
                  api: api)),
          BlocProvider(
              create: (context) => TorrentFileInfoBloc(
                  api: api))
        ],
          child: TorrentCardScreen(),),
        '/add_torrent': (context) => BlocProvider(
          create: (context) => AddTorrentBloc(
              api: api),
          child: AddTorrentScreen(),
        ),
      },
    );
  }
}