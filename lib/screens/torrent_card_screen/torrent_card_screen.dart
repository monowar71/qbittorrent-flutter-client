import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:qbittorrent_client/repositories/qbittorrent_web_api.dart';
import 'package:qbittorrent_client/models/torrent_info.dart';
import 'package:qbittorrent_client/screens/torrent_card_screen/tabs/base_info_tab/base_info_tab.dart';
import 'package:qbittorrent_client/screens/torrent_card_screen/tabs/files_info_tab/files_info_tab.dart';

class TorrentCardScreen extends StatefulWidget {
  const TorrentCardScreen({Key? key, required this.torrentInfo}) : super(key: key);

  final TorrentInfo torrentInfo;

  @override
  State<TorrentCardScreen> createState() => _TorrentCardScreenState();
}

class _TorrentCardScreenState extends State<TorrentCardScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late TorrentInfo _torrentInfo;

  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _torrentInfo = widget.torrentInfo;

    _tabController = TabController(length: 2, vsync: this);
    _startAutoRefresh();
    _fetchTorrentInfo();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _refreshTimer?.cancel();
    super.dispose();
  }

  void _startAutoRefresh() {
    _refreshTimer = Timer.periodic(const Duration(seconds: 1), (_) => _fetchTorrentInfo());
  }

  Future<void> _fetchTorrentInfo() async {
    try {
      final torrent = await GetIt.I<QbittorrentWebApi>().getTorrentData(widget.torrentInfo.hash!);
      if (mounted) {
        setState(() {
          _torrentInfo = torrent;
        });
      }
    } catch (e) {
      debugPrint("Error fetching torrent info: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Детали торрента',
          style: TextStyle(fontSize: 20),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Основные'),
            Tab(text: 'Файлы'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          BaseInfoTab(torrentInfo: _torrentInfo),
          FilesInfoTab(torrentInfo: _torrentInfo),
        ],
      ),
    );
  }
}
