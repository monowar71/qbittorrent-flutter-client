import 'package:flutter/material.dart';
import 'package:qbittorrent_client/repositories/torrent_info.dart';

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
          Text('Seeds: ${torrentInfo.numSeeds}'),
          Text('Peers: ${torrentInfo.numLeechs}'),
        ]
    );
  }
}
