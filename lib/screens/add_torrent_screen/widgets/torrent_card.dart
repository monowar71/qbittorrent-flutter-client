import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qbittorrent_client/bloc/add_torrent/add_torrent_bloc.dart';
import 'package:qbittorrent_client/models/added_torrent_settings.dart';
import 'package:qbittorrent_client/screens/auth_screen/widgets/labeled_switch.dart';

class TorrentCard extends StatelessWidget {
  final AddedTorrentSettings settings;

  const TorrentCard({super.key, required this.settings});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              settings.filePath!.split('/').last,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LabeledSwitch(
                  label: "Пауза при старте",
                  initialValue: settings.paused ?? false,
                  onChanged: (e) => settings.paused = e,
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    context.read<AddTorrentBloc>().add(ClearFileEvent(settings: settings));
                  },
                ),
              ],
            ),
            LabeledSwitch(
              label: "Пропустить проверку",
              initialValue: settings.skipChecking ?? false,
              onChanged: (e) => settings.skipChecking = e,
            ),
          ],
        ),
      ),
    );
  }
}
