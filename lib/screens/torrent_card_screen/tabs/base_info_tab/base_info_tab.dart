import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qbittorrent_client/bloc/torrents/torrents_bloc.dart';
import 'package:qbittorrent_client/models/torrent_info.dart';
import 'package:qbittorrent_client/screens/torrent_card_screen/tabs/base_info_tab/widgets/info_row.dart';
import 'package:qbittorrent_client/screens/torrent_card_screen/tabs/base_info_tab/widgets/section_header.dart';
import 'package:qbittorrent_client/screens/torrent_card_screen/tabs/base_info_tab/widgets/speed_info.dart';
import 'package:qbittorrent_client/screens/torrent_card_screen/tabs/base_info_tab/widgets/file_size_info.dart';
import 'package:qbittorrent_client/screens/torrent_card_screen/tabs/base_info_tab/widgets/torrent_actions_buttons.dart';
import 'widgets/seed_peers_info.dart';
import 'package:qbittorrent_client/i18n/strings.g.dart';


class BaseInfoTab extends StatefulWidget {
  const BaseInfoTab({super.key, required this.torrentInfo});

  final TorrentInfo torrentInfo;

  @override
  State<BaseInfoTab> createState() => _BaseInfoTabState();
}

class _BaseInfoTabState extends State<BaseInfoTab> {
  late StreamSubscription _timerSubscription;
  late TorrentInfo _currentTorrentInfo;

  @override
  void initState() {
    super.initState();

    _currentTorrentInfo = widget.torrentInfo;

    _timerSubscription = Stream.periodic(const Duration(seconds: 2)).listen((_) {
      if (mounted) {
        context.read<TorrentsBloc>().add(FetchTorrentInfoEvent(hash: widget.torrentInfo.hash!));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TorrentsBloc, TorrentsState>(
      listener: (context, state) {
        if (state is TorrentInfoDeleted) {
          Navigator.pushReplacementNamed(context, '/torrents');
        }
      },
      builder: (context, state) {
        if (state is TorrentInfoLoaded) {
          _currentTorrentInfo = state.torrentInfo;
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FileSizeInfo(torrentInfo: _currentTorrentInfo),
                const SizedBox(height: 20),
                SectionHeader(title: t.torrent_card_screen.base_info_tab.main_info_label),
                InfoRow(label: t.torrent_card_screen.base_info_tab.hash_label, value: _currentTorrentInfo.hash!),
                InfoRow(label: t.torrent_card_screen.base_info_tab.status_label, value: _currentTorrentInfo.state.toString()),
                InfoRow(label: t.torrent_card_screen.base_info_tab.name_label, value: _currentTorrentInfo.name!),
                InfoRow(label: t.torrent_card_screen.base_info_tab.tags_label, value: _currentTorrentInfo.tags!),
                InfoRow(label: t.torrent_card_screen.base_info_tab.category_label, value: _currentTorrentInfo.category!),
                InfoRow(label: t.torrent_card_screen.base_info_tab.magnet_uri_label, value: _currentTorrentInfo.magnetUri!),
                InfoRow(label: t.torrent_card_screen.base_info_tab.save_path_label, value: _currentTorrentInfo.savePath!),
                const SizedBox(height: 20),
                SectionHeader(title: t.torrent_card_screen.base_info_tab.seeds_peers_section_title),
                SeedPeersInfo(torrentInfo: _currentTorrentInfo),
                const SizedBox(height: 20),
                SectionHeader(title: t.torrent_card_screen.base_info_tab.speed_section_title),
                SpeedInfo(torrentInfo: _currentTorrentInfo),
                const SizedBox(height: 20),
                TorrentActionsButtons(torrentInfo: _currentTorrentInfo),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _timerSubscription.cancel();
    super.dispose();
  }
}

