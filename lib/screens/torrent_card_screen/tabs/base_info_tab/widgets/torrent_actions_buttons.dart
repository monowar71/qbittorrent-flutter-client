import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:qbittorrent_client/repositories/qbittorrent_web_api.dart';
import 'package:qbittorrent_client/models/torrent_info.dart';
import 'package:qbittorrent_client/screens/torrents_list_screen/torrents_list_screen.dart';

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
                GetIt.I.get<QbittorrentWebApi>().startTorrents([torrentInfo.hash!]);
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
                GetIt.I.get<QbittorrentWebApi>().stopTorrents([torrentInfo.hash!]);
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
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Удаление торрента'),
          content: Text('Как вы хотите удалить?'),
          actions: [
            TextButton(
              onPressed: () {
                GetIt.I.get<QbittorrentWebApi>().deleteTorrents(hashes: [torrentInfo.hash!], deleteFiles: false);
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>
                    TorrentsListScreen()));
              },
              child: Text('Только торрент'),
            ),
            TextButton(
              onPressed: () {
                GetIt.I.get<QbittorrentWebApi>().deleteTorrents(hashes: [torrentInfo.hash!], deleteFiles: true);
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>
                    TorrentsListScreen()));
              },
              child: Text('Торрент и файлы'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Отмена'),
            ),
          ],
        );
      },
    );
  }
}

