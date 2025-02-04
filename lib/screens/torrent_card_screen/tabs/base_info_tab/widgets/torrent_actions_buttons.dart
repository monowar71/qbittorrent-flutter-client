import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qbittorrent_client/bloc/torrents/torrents_bloc.dart';
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
                  Text('Запустить'),
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
                  Text('Остановить'),
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
              Text('Удалить', style: TextStyle(color: Colors.white)),
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
          title: Text('Удаление торрента'),
          content: Text('Как вы хотите удалить?'),
          actions: [
            TextButton(
              onPressed: () {
                context.read<TorrentsBloc>()
                    .add(DeleteTorrentEvent(
                    hash: torrentInfo.hash!,
                    deleteFiles: false));
              },
              child: Text('Только торрент'),
            ),
            TextButton(
              onPressed: () {
                context.read<TorrentsBloc>()
                    .add(DeleteTorrentEvent(
                    hash: torrentInfo.hash!,
                    deleteFiles: true));
              },
              child: Text('Торрент и файлы'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text('Отмена'),
            ),
          ],
        );
      },
    );
  }
}

