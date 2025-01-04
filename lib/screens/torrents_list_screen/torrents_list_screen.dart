import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:qbittorrent_client/repositories/qbittorrent_web_api.dart';
import 'package:qbittorrent_client/models/torrent_info.dart';
import 'package:qbittorrent_client/screens/torrents_list_screen/widgets/add_torrent_dialog.dart';
import 'package:qbittorrent_client/screens/torrents_list_screen/widgets/torrent_list_card.dart';

class TorrentsListScreen extends StatefulWidget {
  @override
  State<TorrentsListScreen> createState() => _TorrentsListScreenState();
}

class _TorrentsListScreenState extends State<TorrentsListScreen> {
  List<TorrentInfo> downloads = [];
  bool isLoading = true;

  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _getTorrentsList();
    _startAutoRefresh();

    const MethodChannel fileOpenChannel = MethodChannel('file_open_channel');
    fileOpenChannel.setMethodCallHandler((call) async {
      if (call.method == 'onFileOpen') {
        final List<dynamic> files = call.arguments;
        debugPrint('Opened files: $files');

        showDialog(
          context: context,
          builder: (BuildContext context) => AddTorrentDialog(torrentPath: files.first),
        );
        // setState(() {
        //   print(files.isNotEmpty ? files.first : "No file opened");
        // });
      }
    });


  }

  void _startAutoRefresh() {
    _refreshTimer = Timer.periodic(Duration(seconds: 1), (_) {
      _getTorrentsList();
    });
  }

  Future<void> _getTorrentsList() async {
    try {
      final torrents = await GetIt.I<QbittorrentWebApi>().getTorrentsList();
      setState(() {
        downloads = torrents;
        downloads.sort((a, b) => b.addedOn!.compareTo(a.addedOn!));
        isLoading = false;
      });
    } catch (e) {
      print("Ошибка загрузки торрентов: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _cancelAutoRefresh();
    super.dispose();
  }

  void _cancelAutoRefresh() {
    _refreshTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Список загрузок"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : downloads.isEmpty
          ? const Center(child: Text("Нет активных загрузок"))
          : ListView.builder(
        itemCount: downloads.length,
        itemBuilder: (context, index) {
          final item = downloads[index];
          return TorrentListCard(item: item);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTorrentDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTorrentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AddTorrentDialog(),
    );
  }
}
