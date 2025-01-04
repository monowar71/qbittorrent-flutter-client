import 'package:flutter/material.dart';
import 'package:qbittorrent_client/models/torrent_info.dart';
import 'package:qbittorrent_client/repositories/utils.dart';

class FileSizeInfo extends StatelessWidget {
  const FileSizeInfo({super.key, required this.torrentInfo});
  final TorrentInfo torrentInfo;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(fontSize: 14); // Общий стиль для текста
    final greenTextStyle = textStyle.copyWith(color: Colors.green);
    final redTextStyle = textStyle.copyWith(color: Colors.red);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row with total size and ratio
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Общий размер: ${formatBytes(torrentInfo.totalSize!)}',
              style: textStyle,
            ),
            Text(
              'Соотношение: ${torrentInfo.ratio!.toStringAsFixed(1)}',
              style: textStyle,
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Progress bar
        Stack(
          children: [
            Container(
              height: 20,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            FractionallySizedBox(
              widthFactor: torrentInfo.progress,
              child: Container(
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Row with completed size and left size
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Уже скачанно: ${formatBytes(torrentInfo.completed)}',
              style: greenTextStyle,
            ),
            Text(
              'Осталось скачать: ${formatBytes(torrentInfo.amountLeft!)}',
              style: redTextStyle,
            ),
          ],
        ),
      ],
    );
  }
}
