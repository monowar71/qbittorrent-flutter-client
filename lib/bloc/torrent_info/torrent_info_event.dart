part of 'torrent_info_bloc.dart';

abstract class TorrentInfoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchTorrentInfoEvent extends TorrentInfoEvent {
  final String hash;

  FetchTorrentInfoEvent({required this.hash});
}