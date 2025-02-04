part of 'torrent_file_info_bloc.dart';

sealed class TorrentFileInfoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}
class FetchTorrentFileInfoEvent extends TorrentFileInfoEvent {
  final String hash;

  FetchTorrentFileInfoEvent({required this.hash});
}
