import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qbittorrent_client/bloc/torrents/torrents_bloc.dart';
import 'package:qbittorrent_client/screens/torrents_list_screen/widgets/torrent_list_card.dart';

class TorrentsListScreen extends StatefulWidget {
  const TorrentsListScreen({super.key});

  @override
  State<TorrentsListScreen> createState() => _TorrentsListScreenState();
}

class _TorrentsListScreenState extends State<TorrentsListScreen> {
  late StreamSubscription _timerSubscription;

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
        title: const Text('Список торрентов'),
      ),
      body: BlocBuilder<TorrentsBloc, TorrentsState>(
          builder: (context, state) {
            if(state is TorrentInfoLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if(state is TorrentsError) {
              return Center(child: Text('Ошибка загрузки торрентов ${state.error}'));
            }
            if(state is TorrentsListInfoLoaded) {
              return ListView.builder(
                itemCount: state.torrents.length,
                itemBuilder: (context, index) {
                  state.torrents.sort((a, b) => b.addedOn!.compareTo(a.addedOn!));
                  final item = state.torrents[index];
                  return TorrentListCard(item: item);
                },
              );
            }
            return const Center(child: Text('Нет активных торрентов'));
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}


  // void _showAddTorrentDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) => AddTorrentDialog(),
  //   );
  // }

