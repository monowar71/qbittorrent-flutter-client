import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qbittorrent_client/bloc/add_torrent/add_torrent_bloc.dart';
import 'package:qbittorrent_client/i18n/strings.g.dart';

class FilePickerSection extends StatelessWidget {
  const FilePickerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () => context.read<AddTorrentBloc>().add(PickFileEvent()),
              icon: const Icon(Icons.folder_open),
              label: Text(t.add_torrent_screen.file_picker_section.add_files_button_label),
            ),
          ],
        ),
      ),
    );
  }
}
