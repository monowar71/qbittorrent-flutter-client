import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:qbittorrent_client/models/file_info.dart';
import 'package:qbittorrent_client/repositories/qbittorrent_web_api.dart';
import 'package:qbittorrent_client/models/torrent_info.dart';

import 'widgets/file_card.dart';

class FilesInfoTab extends StatefulWidget {
  const FilesInfoTab({super.key, required this.torrentInfo});
  final TorrentInfo torrentInfo;

  @override
  State<FilesInfoTab> createState() => _FilesInfoTabState();
}

class _FilesInfoTabState extends State<FilesInfoTab> {
  List<FileInfo> files = [];

  Future getFilesInfo() async {
    files = await GetIt.I.get<QbittorrentWebApi>().getTorrentFiles(widget.torrentInfo.hash!);
    setState(() {

    });
  }
  @override
  void initState() {
    super.initState();
    getFilesInfo();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: files.length,
        itemBuilder: (context, index) {
          final file = files[index];
          return FileCard(file: file, torrentInfo: widget.torrentInfo);
        },
      );
  }
}

