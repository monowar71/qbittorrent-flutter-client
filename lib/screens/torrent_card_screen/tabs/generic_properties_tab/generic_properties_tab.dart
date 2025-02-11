import 'package:flutter/material.dart';
import 'package:qbittorrent_client/models/torrent_info.dart';

class GenericPropertiesTab extends StatefulWidget {
  const GenericPropertiesTab({super.key, required this.torrentInfo});

  final TorrentInfo torrentInfo;

  @override
  State<GenericPropertiesTab> createState() => _BaseInfoTabState();
}

class _BaseInfoTabState extends State<GenericPropertiesTab> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Generic Properties"),
    );
  }

}

