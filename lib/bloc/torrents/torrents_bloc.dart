import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qbittorrent_client/api/qbittorrent_api.dart';
import 'package:qbittorrent_client/models/torrent_info.dart';

part 'torrents_event.dart';
part 'torrents_state.dart';

class TorrentsBloc extends Bloc<TorrentsEvent, TorrentsState> {
  final QBittorrentApi api;

  TorrentsBloc({required this.api}) : super(TorrentInitial()) {
    on<FetchTorrentsListEvent>(_onFetchTorrentsListEvent);
    on<FetchTorrentInfoEvent>( _onFetchTorrentInfoEvent);
    on<ResumeTorrentEvent>( _onResumeTorrentEvent);
    on<PauseTorrentEvent>( _onPauseTorrentEvent);
    on<DeleteTorrentEvent>( _onDeleteTorrentEvent);
  }

  Future<void> _onFetchTorrentsListEvent(
      FetchTorrentsListEvent event,
      Emitter<TorrentsState> emit,
      ) async {
    try {
      final torrents = await api.getTorrentsList();
      emit(TorrentsListInfoLoaded(torrents: torrents));
    } catch (e) {
      emit(TorrentsError(error: e.toString()));
    }
  }

  Future<void> _onFetchTorrentInfoEvent(
      FetchTorrentInfoEvent event,
      Emitter<TorrentsState> emit,
      ) async {
    try {
      final torrent = await api.getTorrentData(event.hash);
      emit(TorrentInfoLoaded(torrentInfo: torrent));
    } catch (e) {
      emit(TorrentsError(error: e.toString()));
    }
  }

  Future<void> _onResumeTorrentEvent(
      ResumeTorrentEvent event,
      Emitter<TorrentsState> emit,
      ) async {
    try {
      await api.resumeTorrents(event.hash);
    }
    catch (e) {
      emit(TorrentsError(error: e.toString()));
    }
  }

  Future<void> _onPauseTorrentEvent(
      PauseTorrentEvent event,
      Emitter<TorrentsState> emit,
      ) async {
    try {
      await api.pauseTorrents(event.hash);
    }
    catch (e) {
      emit(TorrentsError(error: e.toString()));
    }
  }

  Future<void> _onDeleteTorrentEvent(
      DeleteTorrentEvent event,
      Emitter<TorrentsState> emit,
      ) async {
    try {
      await api.deleteTorrents(event.hash, event.deleteFiles);
      emit(TorrentInfoDeleted());
    }
    catch (e) {
      emit(TorrentsError(error: e.toString()));
    }
  }
}
