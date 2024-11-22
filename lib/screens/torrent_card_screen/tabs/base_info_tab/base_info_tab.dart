import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:qbittorrent_client/repositories/qbittorrent_web_api.dart';
import 'package:qbittorrent_client/repositories/torrent_info.dart';
import 'package:qbittorrent_client/screens/torrent_card_screen/tabs/base_info_tab/widgets/info_row.dart';
import 'package:qbittorrent_client/screens/torrent_card_screen/tabs/base_info_tab/widgets/section_header.dart';
import 'package:qbittorrent_client/screens/torrent_card_screen/tabs/base_info_tab/widgets/speed_info.dart';
import 'package:qbittorrent_client/screens/torrent_card_screen/tabs/base_info_tab/widgets/file_size_info.dart';
import 'package:qbittorrent_client/screens/torrent_card_screen/tabs/base_info_tab/widgets/torrent_actions_buttons.dart';
import 'widgets/seed_peers_info.dart';

class BaseInfoTab extends StatelessWidget {
  const BaseInfoTab({super.key, required this.torrentInfo});
  final TorrentInfo torrentInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'Basic Information'),
            InfoRow(label: 'HASH', value: torrentInfo.hash),
            InfoRow(label: 'Status', value: torrentInfo.state),
            InfoRow(label: 'Name', value: torrentInfo.name),
            InfoRow(label: 'Tag', value: torrentInfo.tags),
            InfoRow(label: 'Category', value: torrentInfo.category),
            InfoRow(label: 'MagnetLink', value: torrentInfo.magnetUri),
            InfoRow(label: 'Download dir', value: torrentInfo.savePath),
            const SizedBox(height: 20),

            const SectionHeader(title: 'Seeds/Peers'),
            SeedPeersInfo(torrentInfo: torrentInfo),
            const SizedBox(height: 20),

            const SectionHeader(title: 'Speed'),
            SpeedInfo(torrentInfo: torrentInfo),
            const SizedBox(height: 20),

            const SectionHeader(title: 'File Size'),
            FileSizeInfo(torrentInfo: torrentInfo),
            const SizedBox(height: 20),
            TorrentActionsButtons(torrentInfo: torrentInfo),

          ],
        ),
      ),
    );
  }
}

