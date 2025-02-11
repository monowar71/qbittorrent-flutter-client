import 'package:flutter/material.dart';
import 'package:qbittorrent_client/i18n/strings.g.dart';
import 'package:qbittorrent_client/models/torrent_info.dart';
import 'package:qbittorrent_client/screens/torrent_card_screen/tabs/base_info_tab/base_info_tab.dart';
import 'package:qbittorrent_client/screens/torrent_card_screen/tabs/files_info_tab/files_info_tab.dart';
import 'package:qbittorrent_client/screens/torrent_card_screen/tabs/generic_properties_tab/generic_properties_tab.dart';

class TorrentCardScreen extends StatelessWidget {
  const TorrentCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final torrentInfo = ModalRoute.of(context)!.settings.arguments as TorrentInfo;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            t.torrent_card_screen.title,
            style: TextStyle(fontSize: 20),
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: t.torrent_card_screen.base_info_tab_label),
              Tab(text: 'generic'),
              Tab(text: t.torrent_card_screen.files_info_tab_label),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            BaseInfoTab(torrentInfo: torrentInfo),
            GenericPropertiesTab(torrentInfo: torrentInfo),
            FilesInfoTab(torrentInfo: torrentInfo),
          ],
        ),
      ),
    );
  }
}
