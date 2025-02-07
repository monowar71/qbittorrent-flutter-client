import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:qbittorrent_client/bloc/add_torrent/add_torrent_bloc.dart';
import 'package:qbittorrent_client/bloc/torrent_file_info/torrent_file_info_bloc.dart';
import 'package:qbittorrent_client/bloc/torrents/torrents_bloc.dart';
import 'package:qbittorrent_client/i18n/strings.g.dart';
import 'package:qbittorrent_client/repositories/local_storage_repository.dart';
import 'package:qbittorrent_client/screens/add_torrent_screen/add_torrent_screen.dart';
import 'package:qbittorrent_client/screens/auth_screen/auth_screen.dart';
import 'package:qbittorrent_client/screens/torrent_card_screen/torrent_card_screen.dart';
import 'package:qbittorrent_client/screens/torrents_list_screen/torrents_list_screen.dart';

import 'api/qbittorrent_api.dart';
import 'bloc/auth/auth_bloc.dart';

class QbittorrentClientApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: TranslationProvider.of(context).flutterLocale,
      initialRoute: '/auth',
      routes: {
        '/auth': (context) => BlocProvider(
          create: (context) => AuthBloc(
            api: GetIt.I<QBittorrentApi>(),
            localStorageRepository: GetIt.I<LocalStorageRepository>()),
          child: AuthScreen(),
        ),
        '/torrents': (context) => BlocProvider(
          create: (context) => TorrentsBloc(
              api: GetIt.I<QBittorrentApi>()),
          child: TorrentsListScreen(),
        ),
        '/torrent_info': (context) => MultiBlocProvider(providers: [
          BlocProvider(
              create: (context) => TorrentsBloc(
                  api: GetIt.I<QBittorrentApi>())),
          BlocProvider(
              create: (context) => TorrentFileInfoBloc(
                  api: GetIt.I<QBittorrentApi>()))
        ],
          child: TorrentCardScreen(),),
        '/add_torrent': (context) => BlocProvider(
          create: (context) => AddTorrentBloc(
              api: GetIt.I<QBittorrentApi>()),
          child: AddTorrentScreen(),
        ),
      },
    );
  }
}