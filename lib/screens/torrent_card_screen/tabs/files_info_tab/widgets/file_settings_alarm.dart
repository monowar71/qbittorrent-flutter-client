import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qbittorrent_client/bloc/torrent_file_info/torrent_file_info_bloc.dart';
import 'package:qbittorrent_client/models/file_info.dart';
import 'package:qbittorrent_client/models/file_priority.dart';
import 'package:qbittorrent_client/models/torrent_info.dart';

class FileSettingsDialog extends StatefulWidget {
  const FileSettingsDialog({super.key, required this.fileInfo, required this.torrent});

  final TorrentInfo torrent;
  final FileInfo fileInfo;

  @override
  State<FileSettingsDialog> createState() => FileSettingsDialogState();
}

class FileSettingsDialogState extends State<FileSettingsDialog> {

  late TextEditingController _nameController;
  late int _priority;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.fileInfo.name);
    _priority = widget.fileInfo.priority.toInt()!;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Настройки файла'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Название файла',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          DropdownButtonFormField<int>(
            value: _priority,
            decoration: InputDecoration(
              labelText: 'Приоритет',
              border: OutlineInputBorder(),
            ),
            items: FilePriority.enumToJson.entries.map((entry) {
              return DropdownMenuItem<int>(
                value: entry.value,
                child: Text(FilePriority.localizedNames[entry.key] ?? 'Неизвестно'),
              );
            }).toList(),
            onChanged: (value) {
                _priority = value ?? 1;
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Отмена'),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<TorrentFileInfoBloc>().add(
                RenameTorrentFileEvent(
                  hash: widget.torrent.hash!,
                  oldName: widget.fileInfo.name,
                  newName: _nameController.text)
            );
            context.read<TorrentFileInfoBloc>().add(
                SetFilePriorityEvent(
                    hash: widget.torrent.hash!,
                    fileId: widget.fileInfo.index.toString(),
                    priority: _priority)
            );
            Navigator.of(context).pop();
          },
          child: const Text('Подтвердить'),
        ),
      ],
    );
  }
}
