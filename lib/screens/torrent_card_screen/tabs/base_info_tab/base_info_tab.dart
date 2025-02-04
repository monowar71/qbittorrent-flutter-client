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
                const SectionHeader(title: 'Основная информация'),
                InfoRow(label: 'Хеш', value: _currentTorrentInfo.hash!),
                InfoRow(label: 'Статус', value: _currentTorrentInfo.state.toLocalizedString()),
                InfoRow(label: 'Имя', value: _currentTorrentInfo.name!),
                InfoRow(label: 'Тег', value: _currentTorrentInfo.tags!),
                InfoRow(label: 'Категория', value: _currentTorrentInfo.category!),
                InfoRow(label: 'Магнет-ссылка', value: _currentTorrentInfo.magnetUri!),
                InfoRow(label: 'Адрес сохранения', value: _currentTorrentInfo.savePath!),
                const SizedBox(height: 20),
                const SectionHeader(title: 'Сиды/пиры'),
                SeedPeersInfo(torrentInfo: _currentTorrentInfo),
                const SizedBox(height: 20),
                const SectionHeader(title: 'Скорость'),
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

