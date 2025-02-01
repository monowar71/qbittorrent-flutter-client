import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qbittorrent_client/bloc/torrent_info/torrent_info_bloc.dart';
import 'package:qbittorrent_client/models/torrent_info.dart';
import 'package:qbittorrent_client/screens/torrent_card_screen/tabs/base_info_tab/base_info_tab.dart';
import 'package:qbittorrent_client/screens/torrent_card_screen/tabs/files_info_tab/files_info_tab.dart';

class TorrentCardScreen extends StatefulWidget {
  TorrentCardScreen({Key? key}) : super(key: key);


  @override
  State<TorrentCardScreen> createState() => _TorrentCardScreenState();
}

class _TorrentCardScreenState extends State<TorrentCardScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late TorrentInfo _torrentInfo;
  late StreamSubscription _timerSubscription;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _timerSubscription = Stream.periodic(Duration(seconds: 2)).listen((_) {
      if (mounted) {
        context.read<TorrentInfoBloc>().add(FetchTorrentInfoEvent(hash: _torrentInfo.hash!));
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _timerSubscription.cancel();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    _torrentInfo = ModalRoute.of(context)!.settings.arguments as TorrentInfo;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Детали торрента',
          style: TextStyle(fontSize: 20),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Основные'),
            Tab(text: 'Файлы'),
          ],
        ),
      ),
      body: BlocBuilder<TorrentInfoBloc, TorrentInfoState>(
  builder: (context, state) {
    if (state is TorrentInfoLoaded) {
      return TabBarView(
        controller: _tabController,
        children: [
          BaseInfoTab(torrentInfo: state.torrent),
          FilesInfoTab(torrentInfo: state.torrent),
        ],
      );
    }
    return Center(child: CircularProgressIndicator());
  },
),
    );
  }
}
