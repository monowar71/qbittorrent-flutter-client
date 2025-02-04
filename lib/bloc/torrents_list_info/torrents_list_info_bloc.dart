import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qbittorrent_client/api/qbittorrent_api.dart';
import 'package:qbittorrent_client/models/torrent_info.dart';

part 'torrents_list_info_event.dart';
part 'torrents_list_info_state.dart';

class TorrentsListInfoBloc extends Bloc<TorrentsListInfoEvent, TorrentsListInfoState> {
  final QBittorrentApi api;

  TorrentsListInfoBloc({required this.api}) : super(TorrentsListInfoInitial()) {
    on<FetchTorrentsEvent>(_onFetchTorrentsEvent);
  }

  Future<void> _onFetchTorrentsEvent(
      FetchTorrentsEvent event,
      Emitter<TorrentsListInfoState> emit,
      ) async {
    try {
      final torrents = await api.getTorrentsList();
      emit(TorrentsListInfoLoaded(torrents: torrents));
    } catch (e) {
      emit(TorrentListInfoError(error: e.toString()));
    }
  }
}
