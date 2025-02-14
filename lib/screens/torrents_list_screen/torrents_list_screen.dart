import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qbittorrent_client/bloc/torrents/torrents_bloc.dart';
import 'package:qbittorrent_client/i18n/strings.g.dart';
import 'package:qbittorrent_client/models/torrent_info.dart';
import 'package:qbittorrent_client/screens/torrents_list_screen/widgets/torrent_list_card.dart';

enum SortOption { date, name, size }

class TorrentsListScreen extends StatefulWidget {
  const TorrentsListScreen({super.key});

  @override
  State<TorrentsListScreen> createState() => _TorrentsListScreenState();
}

class _TorrentsListScreenState extends State<TorrentsListScreen> {
  late StreamSubscription _timerSubscription;
  SortOption _selectedSort = SortOption.date;

  @override
  void initState() {
    super.initState();
    _timerSubscription = Stream.periodic(Duration(seconds: 2)).listen((_) {
      if (mounted) {
        context.read<TorrentsBloc>().add(FetchTorrentsListEvent());
      }
    });
  }

  @override
  void dispose() {
    _timerSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.torrent_list_screen.title),
        actions: [
          _buildSortMenu(),
        ],
      ),
      body: BlocBuilder<TorrentsBloc, TorrentsState>(
        builder: (context, state) {
          if (state is TorrentInfoLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is TorrentsError) {
            return Center(child: Text(t.torrent_list_screen.torrents_error.replaceAll('{error}', state.error)));
          }
          if (state is TorrentsListInfoLoaded) {
            final sortedTorrents = _sortTorrents(state.torrents);
            return ListView.builder(
              itemCount: sortedTorrents.length,
              itemBuilder: (context, index) {
                final item = sortedTorrents[index];
                return TorrentListCard(item: item);
              },
            );
          }
          return Center(child: Text(t.torrent_list_screen.no_active_torrents));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTorrentScreen(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSortMenu() {
    return PopupMenuButton<SortOption>(
      onSelected: (SortOption value) {
        setState(() {
          _selectedSort = value;
        });
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: SortOption.date,
          child: Text(t.torrent_list_screen.sort_by.date_added),
        ),
        PopupMenuItem(
          value: SortOption.name,
          child: Text(t.torrent_list_screen.sort_by.name),
        ),
        PopupMenuItem(
          value: SortOption.size,
          child: Text(t.torrent_list_screen.sort_by.size),
        ),
      ],
      icon: Icon(Icons.sort),
    );
  }

  List<TorrentInfo> _sortTorrents(List<TorrentInfo> torrents) {
    List<TorrentInfo> sortedTorrents = List.from(torrents);

    switch (_selectedSort) {
      case SortOption.date:
        sortedTorrents.sort((a, b) => b.addedOn!.compareTo(a.addedOn!));
        break;
      case SortOption.name:
        sortedTorrents.sort((a, b) => a.name!.compareTo(b.name!));
        break;
      case SortOption.size:
        sortedTorrents.sort((a, b) => b.size!.compareTo(a.size!));
        break;
    }

    return sortedTorrents;
  }
}

void _showAddTorrentScreen(BuildContext context) {
  Navigator.pushNamed(context, '/add_torrent');
}
