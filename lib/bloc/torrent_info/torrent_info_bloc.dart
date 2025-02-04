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
    on<FetchTorrentInfoEvent>( _onFetchTorrentInfoEvent);
    on<ResumeTorrentInfoEvent>( _onResumeTorrentInfoEvent);
    on<PauseTorrentInfoEvent>( _onPauseTorrentInfoEvent);
    on<DeleteTorrentInfoEvent>( _onDeleteTorrentInfoEvent);
  }

  Future<void> _onFetchTorrentInfoEvent(
      FetchTorrentInfoEvent event,
      Emitter<TorrentInfoState> emit,
      ) async {
    try {
      final torrent = await api.getTorrentData(event.hash);
      emit(TorrentInfoLoaded(torrentInfo: torrent));
    } catch (e) {
      emit(TorrentInfoError(error: e.toString()));
    }
  }

  Future<void> _onResumeTorrentInfoEvent(
      ResumeTorrentInfoEvent event,
      Emitter<TorrentInfoState> emit,
      ) async {
    try {
      await api.resumeTorrents(event.hash);
      add(FetchTorrentInfoEvent(hash: event.hash));
    }
    catch (e) {
      emit(TorrentInfoError(error: e.toString()));
    }
  }

  Future<void> _onPauseTorrentInfoEvent(
      PauseTorrentInfoEvent event,
      Emitter<TorrentInfoState> emit,
      ) async {
    try {
      await api.pauseTorrents(event.hash);
      add(FetchTorrentInfoEvent(hash: event.hash));
    }
    catch (e) {
      emit(TorrentInfoError(error: e.toString()));
    }
  }

  Future<void> _onDeleteTorrentInfoEvent(
      DeleteTorrentInfoEvent event,
      Emitter<TorrentInfoState> emit,
      ) async {
    try {
      await api.deleteTorrents(event.hash, event.deleteFiles);
      emit(TorrentInfoDeleted());
    }
    catch (e) {
      emit(TorrentInfoError(error: e.toString()));
    }
  }
}
