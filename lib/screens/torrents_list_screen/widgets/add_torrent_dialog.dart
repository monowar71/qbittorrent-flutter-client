import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:qbittorrent_client/models/added_torrent_settings.dart';
import 'package:qbittorrent_client/repositories/qbittorrent_web_api.dart';
import 'package:qbittorrent_client/screens/auth_screen/widgets/labeled_switch.dart';

class AddTorrentDialog extends StatefulWidget {
  final String? torrentPath;

  const AddTorrentDialog({super.key, this.torrentPath});
  @override
  _AddTorrentDialogState createState() => _AddTorrentDialogState();
}

class _AddTorrentDialogState extends State<AddTorrentDialog> {
  final TextEditingController magnetController = TextEditingController();
  AddedTorrentSettings? addedTorrentSettings;

  @override
  Widget build(BuildContext context) {

    if(widget.torrentPath != null){
      setState(() {
        addedTorrentSettings = AddedTorrentSettings(filePath: widget.torrentPath!);
      });
    }

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
              if (addedTorrentSettings != null)
                TextButton(
                  onPressed: _clearSelectedFile,
                  child: const Text(
                      'Очистить', style: TextStyle(color: Colors.red)),
                ),

            ],
          ),
          if (addedTorrentSettings != null) ...[
            const SizedBox(height: 16),
            Text('Выбранный файл: ${addedTorrentSettings!.filePath!.split('/').last}'),
            Column(
               mainAxisSize: MainAxisSize.min,
              children: [
                LabeledSwitch(label: "Пауза при старте", initialValue: false, onChanged: (e){
                  addedTorrentSettings?.paused = !e;
                }),
                LabeledSwitch(label: "Пропустить проверку", initialValue: false, onChanged: (e){
                  addedTorrentSettings?.skipChecking = !e;
                }),
              ],
            ),



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
          onPressed: (){},// _addTorrent,
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
        if (filePath.endsWith('.torrents_list_info')) {
          setState(() {
            addedTorrentSettings = AddedTorrentSettings(filePath: filePath);
            //selectedFile = filePath;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Можно выбрать только файлы с расширением .torrents_list_info')),
          );
        }
      }
    } catch (e) {
      print('Ошибка выбора файла: $e');
    }
  }

  void _clearSelectedFile() {
    setState(() {
      addedTorrentSettings = null;
    });
  }

  /*Future<void> _addTorrent() async {
    final qbApi = GetIt.I<QbittorrentWebApi>();
    try {
      if (addedTorrentSettings != null) {
        await qbApi.uploadTorrentFile(addedTorrentSettings!);
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
  }*/
}
