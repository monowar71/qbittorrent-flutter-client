import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qbittorrent_client/bloc/torrent_file_info/torrent_file_info_bloc.dart';
import 'package:qbittorrent_client/i18n/strings.g.dart';
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
      title: Text(t.torrent_card_screen.files_info_tab.file_settings_dialog.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: t.torrent_card_screen.files_info_tab.file_settings_dialog.name_label,
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          DropdownButtonFormField<int>(
            value: _priority,
            decoration: InputDecoration(
              labelText: t.torrent_card_screen.files_info_tab.file_settings_dialog.priority_label,
              border: OutlineInputBorder(),
            ),
            items: FilePriority.enumToJson.entries.map((entry) {
              return DropdownMenuItem<int>(
                value: entry.value,
                child: Text(FilePriority.localizedNames[entry.key] ?? t.torrent_card_screen.files_info_tab.file_settings_dialog.unknown),
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
          child: Text(t.torrent_card_screen.files_info_tab.file_settings_dialog.cancel_button),
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
          child: Text(t.torrent_card_screen.files_info_tab.file_settings_dialog.confirm_button),
        ),
      ],
    );
  }
}
