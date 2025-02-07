import 'package:flutter/material.dart';
import 'package:qbittorrent_client/i18n/strings.g.dart';
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    _torrentInfo = ModalRoute.of(context)!.settings.arguments as TorrentInfo;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.torrent_card_screen.title,
          style: TextStyle(fontSize: 20),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: t.torrent_card_screen.base_info_tab_label),
            Tab(text: t.torrent_card_screen.files_info_tab_label),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          BaseInfoTab(torrentInfo: _torrentInfo),
          FilesInfoTab(torrentInfo: _torrentInfo),
        ],
      )
    );
  }
}
