import 'package:flutter/material.dart';
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
                    'Размер: ${formatBytes(file.size)}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  Text(
                    'Приоритет: ${file.priority}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Прогресс: ${(file.progress * 100).toStringAsFixed(1)}%',
                    style: TextStyle(
                        color: file.progress >= 1 ? Colors.green : Colors.orange,
                        fontSize: 14),
                  ),
                  Text(
                    'Сидируется: ${file.isSeed == true ? "Да" : "Нет"}',
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
                'Доступно: ${(file.availability * 100).toStringAsFixed(1)}%',
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
      builder: (BuildContext context) => FileSettingsDialog(),
    );
  }
}
