import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:qbittorrent_client/repositories/qbittorrent_web_api.dart';
import 'package:qbittorrent_client/models/torrent_info.dart';
import 'package:qbittorrent_client/repositories/utils.dart';
import 'package:qbittorrent_client/screens/torrent_card_screen/torrent_card_screen.dart';
import 'package:qbittorrent_client/screens/torrents_list_screen/widgets/line_progress_widget.dart';

class TorrentListCard extends StatelessWidget {
  final TorrentInfo item;

  const TorrentListCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addedOn = DateTime.fromMillisecondsSinceEpoch(item.addedOn! * 1000).toLocal().toString();

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            TorrentCardScreen(torrentInfo: item)));
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.name!,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold)
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_month, size: 16),
                      SizedBox(width: 4),
                      Text(addedOn),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.storage, size: 16),
                      SizedBox(width: 4),
                      Text(formatBytes(item.size!)),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${(item.progress! * 100).toStringAsFixed(0)}%",
                      style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(7, 119, 245, 1.0),
                          fontWeight: FontWeight.bold,
                      )),
                  Text(item.state!),
                ],
              ),
              SizedBox(height: 5),
              LineProgressWidget(progress: item.progress!),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 200,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.download),
                            SizedBox(width: 4),
                            Text(formatSpeed (item.dlspeed!) ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.upload),
                            SizedBox(width: 4),
                            Text(formatSpeed(item.upspeed!)),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Row(
                    children: [

                      IconButton(icon: Icon(Icons.play_arrow), onPressed: (){
                        GetIt.I.get<QbittorrentWebApi>().startTorrents([item.hash!]);
                      }),
                      IconButton(icon: Icon(Icons.pause), onPressed: (){
                        GetIt.I.get<QbittorrentWebApi>().stopTorrents([item.hash!]);
                      }),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

