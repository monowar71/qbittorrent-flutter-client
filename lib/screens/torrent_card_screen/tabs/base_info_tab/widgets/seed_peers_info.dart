import 'package:flutter/material.dart';
import 'package:qbittorrent_client/i18n/strings.g.dart';
import 'package:qbittorrent_client/models/torrent_info.dart';

class SeedPeersInfo extends StatelessWidget {
  const SeedPeersInfo({
    super.key,
    required this.torrentInfo,
  });

  final TorrentInfo torrentInfo;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment:MainAxisAlignment.spaceBetween,
        children: [
          Text('${t.torrent_card_screen.base_info_tab.seed_peers_info.seeds_label}  ${torrentInfo.numSeeds}'),
          Text('${t.torrent_card_screen.base_info_tab.seed_peers_info.peers_label}  ${torrentInfo.numLeechs}'),
        ]
    );
  }
}
