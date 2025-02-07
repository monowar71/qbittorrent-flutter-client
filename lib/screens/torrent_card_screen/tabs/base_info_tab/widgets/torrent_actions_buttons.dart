import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qbittorrent_client/bloc/torrents/torrents_bloc.dart';
import 'package:qbittorrent_client/i18n/strings.g.dart';
import 'package:qbittorrent_client/models/torrent_info.dart';

class TorrentActionsButtons extends StatelessWidget {
  const TorrentActionsButtons({
    super.key,
    required this.torrentInfo,
  });

  final TorrentInfo torrentInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<TorrentsBloc>()
                    .add(ResumeTorrentEvent(hash: torrentInfo.hash!));
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.play_arrow),
                  Text(t.torrent_card_screen.base_info_tab.torrent_actions_buttons.resume_button),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<TorrentsBloc>()
                    .add(PauseTorrentEvent(hash: torrentInfo.hash!));
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.pause),
                  Text(t.torrent_card_screen.base_info_tab.torrent_actions_buttons.pause_button),
                ],
              ),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () => _showDeleteConfirmationDialog(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.delete, color: Colors.white),
              Text(t.torrent_card_screen.base_info_tab.torrent_actions_buttons.delete_button, style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ],
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(t.torrent_card_screen.base_info_tab.torrent_actions_buttons.delete_confirmation_title),
          content: Text(t.torrent_card_screen.base_info_tab.torrent_actions_buttons.delete_confirmation_message),
          actions: [
            TextButton(
              onPressed: () {
                context.read<TorrentsBloc>()
                    .add(DeleteTorrentEvent(
                    hash: torrentInfo.hash!,
                    deleteFiles: false));
              },
              child: Text(t.torrent_card_screen.base_info_tab.torrent_actions_buttons.delete_only_torrent),
            ),
            TextButton(
              onPressed: () {
                context.read<TorrentsBloc>()
                    .add(DeleteTorrentEvent(
                    hash: torrentInfo.hash!,
                    deleteFiles: true));
              },
              child: Text(t.torrent_card_screen.base_info_tab.torrent_actions_buttons.delete_torrent_and_files),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text(t.torrent_card_screen.base_info_tab.torrent_actions_buttons.cancel_button),
            ),
          ],
        );
      },
    );
  }
}

