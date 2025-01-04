import 'package:flutter/material.dart';
import 'package:qbittorrent_client/models/added_torrent_settings.dart';

class FileSettingsDialog extends StatefulWidget {
  @override
  _FileSettingsDialogState createState() => _FileSettingsDialogState();
}

class _FileSettingsDialogState extends State<FileSettingsDialog> {
  final TextEditingController magnetController = TextEditingController();
  AddedTorrentSettings? addedTorrentSettings;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Настройки файла'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Отмена'),
        ),
        ElevatedButton(
          onPressed: (){},
          child: const Text('Подтвердить'),
        ),
      ],
    );
  }
}
