import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qbittorrent_client/bloc/torrent_file_info/torrent_file_info_bloc.dart';
import 'package:qbittorrent_client/i18n/strings.g.dart';
import 'package:qbittorrent_client/models/file_info.dart';
import 'package:qbittorrent_client/models/torrent_info.dart';
import 'package:qbittorrent_client/utils.dart';
import 'package:qbittorrent_client/screens/torrent_card_screen/tabs/files_info_tab/widgets/file_settings_alarm.dart';

class FileCard extends StatelessWidget {
  final TorrentInfo torrentInfo;
  final FileInfo file;

  const FileCard({super.key, required this.file, required this.torrentInfo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showFileSettingsDialog(context);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                file.name,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${t.torrent_card_screen.files_info_tab.file_card.size_label}: ${formatBytes(file.size)}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    '${t.torrent_card_screen.files_info_tab.file_card.priority_label}: ${file.priority}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${t.torrent_card_screen.files_info_tab.file_card.progress_label}: ${(file.progress * 100).toStringAsFixed(1)}%',
                    style: TextStyle(
                        color: file.progress >= 1 ? Colors.green : Colors
                            .orange,
                        fontSize: 14),
                  ),
                  Text(
                    '${t.torrent_card_screen.files_info_tab.file_card.seeding_label}: '
                        '${file.isSeed == true ?
                    t.torrent_card_screen.files_info_tab.file_card.yes :
                    t.torrent_card_screen.files_info_tab.file_card.no}',
                    style: const TextStyle(fontSize: 14),
                  ),

                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: file.progress,
                  backgroundColor: Colors.grey[800],
                  color: file.progress >= 1 ? Colors.green : Colors.orange,
                  minHeight: 8,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${t.torrent_card_screen.files_info_tab.file_card.available_label}: ${(file.availability * 100).toStringAsFixed(1)}%',
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFileSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) =>
          BlocProvider.value(
            value: context.read<TorrentFileInfoBloc>(),
            child: FileSettingsDialog(fileInfo: file, torrent: torrentInfo,),
          ),
    );
  }
}
