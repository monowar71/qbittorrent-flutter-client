import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qbittorrent_client/api/qbittorrent_api.dart';
import 'package:qbittorrent_client/models/torrent_info.dart';

part 'torrent_info_event.dart';
part 'torrent_info_state.dart';

class TorrentInfoBloc extends Bloc<TorrentInfoEvent, TorrentInfoState> {
  final QBittorrentApi api;

  TorrentInfoBloc({required this.api}) : super(TorrentInfoInitial()) {
    on<FetchTorrentInfoEvent>(_onFetchTorrentInfoEvent);
  }

  Future<void> _onFetchTorrentInfoEvent(
      FetchTorrentInfoEvent event,
      Emitter<TorrentInfoState> emit,
      ) async {
    try {
      final torrent = await api.getTorrentData(event.hash);
      emit(TorrentInfoLoaded(torrent: torrent));
    } catch (e) {
      emit(TorrentInfoError(error: e.toString()));
    }
  }
}
