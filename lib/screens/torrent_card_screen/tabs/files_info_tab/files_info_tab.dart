import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qbittorrent_client/bloc/torrent_file_info/torrent_file_info_bloc.dart';
import 'package:qbittorrent_client/models/torrent_info.dart';

import 'widgets/file_card.dart';

class FilesInfoTab extends StatefulWidget {
  const FilesInfoTab({super.key, required this.torrentInfo});

  final TorrentInfo torrentInfo;

  @override
  State<FilesInfoTab> createState() => _FilesInfoTabState();
}

class _FilesInfoTabState extends State<FilesInfoTab> {
  late StreamSubscription _timerSubscription;

  @override
  void initState() {
    super.initState();

    _timerSubscription = Stream.periodic(Duration(seconds: 2)).listen((_) {
      if (mounted) {
        context.read<TorrentFileInfoBloc>().add(
            FetchTorrentFileInfoEvent(hash: widget.torrentInfo.hash!));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TorrentFileInfoBloc, TorrentFileInfoState>(
      builder: (context, state) {
        if (state is TorrentFileInfoLoaded) {
          return ListView.builder(
            itemCount: state.fileInfos.length,
            itemBuilder: (context, index) {
              final file = state.fileInfos[index];
              return FileCard(file: file, torrentInfo: widget.torrentInfo);
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  void dispose() {
    _timerSubscription.cancel();
    super.dispose();
  }
}

