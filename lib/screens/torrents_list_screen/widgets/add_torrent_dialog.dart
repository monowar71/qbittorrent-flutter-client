import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:qbittorrent_client/repositories/qbittorrent_web_api.dart';

class AddTorrentDialog extends StatefulWidget {
  @override
  _AddTorrentDialogState createState() => _AddTorrentDialogState();
}

class _AddTorrentDialogState extends State<AddTorrentDialog> {
  final TextEditingController magnetController = TextEditingController();
  String? selectedFile;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Добавить торрент'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: _pickFile,
                icon: const Icon(Icons.folder_open),
                label: const Text('Выбрать файл'),
              ),
              if (selectedFile != null)
                TextButton(
                  onPressed: _clearSelectedFile,
                  child: const Text('Очистить', style: TextStyle(color: Colors.red)),
                ),
            ],
          ),
          if (selectedFile != null) ...[
            const SizedBox(height: 16),
            Text('Выбранный файл: ${selectedFile!.split('/').last}'),
          ],
          const SizedBox(height: 16),
          const Text('Или введите magnet-ссылку:'),
          const SizedBox(height: 8),
          TextField(
            controller: magnetController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Magnet-ссылка',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Отмена'),
        ),
        ElevatedButton(
          onPressed: _addTorrent,
          child: const Text('Добавить'),
        ),
      ],
    );
  }

  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles();
      if (result != null && result.files.single.path != null) {
        final filePath = result.files.single.path!;
        if (filePath.endsWith('.torrent')) {
          setState(() {
            selectedFile = filePath;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Можно выбрать только файлы с расширением .torrent')),
          );
        }
      }
    } catch (e) {
      print('Ошибка выбора файла: $e');
    }
  }

  void _clearSelectedFile() {
    setState(() {
      selectedFile = null;
    });
  }

  Future<void> _addTorrent() async {
    final qbApi = GetIt.I<QbittorrentWebApi>();
    try {
      if (selectedFile != null) {
        await qbApi.uploadTorrentFile(selectedFile!, paused: false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Файл успешно добавлен')),
        );
      } else if (magnetController.text.isNotEmpty) {
        await qbApi.uploadMagnetLink(magnetController.text, paused: false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Magnet-ссылка успешно добавлена')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Необходимо выбрать файл или ввести ссылку')),
        );
      }
      Navigator.of(context).pop();
    } catch (e) {
      print('Ошибка добавления торрента: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ошибка добавления торрента')),
      );
    }
  }
}
