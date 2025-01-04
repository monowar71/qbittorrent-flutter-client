import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:qbittorrent_client/repositories/qbittorrent_web_api.dart';
import 'package:qbittorrent_client/models/torrent_info.dart';
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
            const SectionHeader(title: 'Основная информация'),
            InfoRow(label: 'Хеш', value: torrentInfo.hash!),
            InfoRow(label: 'Статус', value: torrentInfo.state!),
            InfoRow(label: 'Имя', value: torrentInfo.name!),
            InfoRow(label: 'Тег', value: torrentInfo.tags!),
            InfoRow(label: 'Категория', value: torrentInfo.category!),
            InfoRow(label: 'Магнет-ссылка', value: torrentInfo.magnetUri!),
            InfoRow(label: 'Адрес сохранения', value: torrentInfo.savePath!),
            const SizedBox(height: 20),

            const SectionHeader(title: 'Сиды/пиры'),
            SeedPeersInfo(torrentInfo: torrentInfo),
            const SizedBox(height: 20),

            const SectionHeader(title: 'Скорость'),
            SpeedInfo(torrentInfo: torrentInfo),
            const SizedBox(height: 20),

            const SectionHeader(title: 'Размер'),
            FileSizeInfo(torrentInfo: torrentInfo),
            const SizedBox(height: 20),
            TorrentActionsButtons(torrentInfo: torrentInfo),

          ],
        ),
      ),
    );
  }
}

