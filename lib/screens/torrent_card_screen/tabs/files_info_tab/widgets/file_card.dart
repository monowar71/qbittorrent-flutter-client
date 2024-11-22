import 'package:flutter/material.dart';
import 'package:qbittorrent_client/repositories/file_info.dart';
import 'package:qbittorrent_client/repositories/utils.dart';

class FileCard extends StatelessWidget {
  final FileInfo file;

  const FileCard({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  'Size: ${formatBytes(file.size)}',
                  style: const TextStyle(fontSize: 14),
                ),
                Text(
                  'Priority: ${file.priority}',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Progress: ${(file.progress * 100).toStringAsFixed(1)}%',
                  style: TextStyle(
                      color: file.progress >= 1 ? Colors.green : Colors.orange,
                      fontSize: 14),
                ),
                Text(
                  'Seeding: ${file.isSeed == true ? "Yes" : "No"}',
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
              'Availability: ${(file.availability * 100).toStringAsFixed(1)}%',
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}