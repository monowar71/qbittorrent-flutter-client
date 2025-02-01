import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:qbittorrent_client/bloc/torrent/torrent_bloc.dart';
import 'package:qbittorrent_client/repositories/local_storage_repository.dart';
import 'package:qbittorrent_client/screens/auth_screen/auth_screen.dart';
import 'package:qbittorrent_client/screens/torrents_list_screen/torrents_list_screen.dart';

import 'api/qbittorrent_api.dart';
import 'bloc/auth/auth_bloc.dart';

class QbittorrentClientApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => BlocProvider(
          create: (context) => AuthBloc(
            api: GetIt.I<QBittorrentApi>(),
            localStorageRepository: GetIt.I<LocalStorageRepository>()),
          child: AuthScreenNew(),
        ),
        '/torrents': (context) => BlocProvider(
          create: (context) => TorrentBloc(api: GetIt.I<QBittorrentApi>()),
          child: TorrentsListScreen(),
        ),
        // '/add-torrent': (context) => BlocProvider(
        //   create: (context) => TorrentBloc(api: GetIt.I<QBittorrentApi>()),
        //   child: AddTorrentScreen(),
        // ),
      },
    );
  }
}