import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:qbittorrent_client/api/qbittorrent_api.dart';
import 'package:qbittorrent_client/models/file_info.dart';

part 'torrent_file_info_event.dart';
part 'torrent_file_info_state.dart';

class TorrentFileInfoBloc extends Bloc<TorrentFileInfoEvent, TorrentFileInfoState> {
  final QBittorrentApi api;

  TorrentFileInfoBloc({required this.api}) : super(TorrentFileInfoInitial()) {
    on<FetchTorrentFileInfoEvent>(_onFetchTorrentFileInfoEvent);
  }

    Future<void> _onFetchTorrentFileInfoEvent(
        FetchTorrentFileInfoEvent event,
        Emitter<TorrentFileInfoState> emit,
        ) async {
      try {
        emit(TorrentFileInfoInitial());
        final fileInfos = await api.getTorrentFiles(event.hash);
        emit(TorrentFileInfoLoaded(fileInfos: fileInfos));
      } catch (e) {
        emit(TorrentFileInfoError(error: e.toString()));
      }
    }
}
