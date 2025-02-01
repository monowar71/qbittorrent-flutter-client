import 'package:flutter/material.dart';
import 'package:qbittorrent_client/models/torrent_info.dart';
import 'package:qbittorrent_client/utils.dart';

class SpeedInfo extends StatelessWidget {
  const SpeedInfo({super.key, required this.torrentInfo});
  final TorrentInfo torrentInfo;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.arrow_downward, color: Colors.blue, size: 16),
            SizedBox(width: 8),
            Text(
              'DOWNLOAD: ${formatSpeed(torrentInfo.dlspeed!)}',
              style: TextStyle(color: Colors.blue, fontSize: 14),
            ),
          ],
        ),
        Row(
          children: [
            Icon(Icons.arrow_upward, color: Colors.red, size: 16),
            SizedBox(width: 8),
            Text(
              'UPLOAD: ${formatSpeed(torrentInfo.upspeed!)}',
              style: TextStyle(color: Colors.red, fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }
}