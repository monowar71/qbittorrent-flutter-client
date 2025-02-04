part of 'torrent_info_bloc.dart';

abstract class TorrentInfoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchTorrentInfoEvent extends TorrentInfoEvent {
  final String hash;

  FetchTorrentInfoEvent({required this.hash});
}

class ResumeTorrentInfoEvent extends TorrentInfoEvent {
  final String hash;

  ResumeTorrentInfoEvent({required this.hash});
}

class PauseTorrentInfoEvent extends TorrentInfoEvent {
  final String hash;

  PauseTorrentInfoEvent({required this.hash});
}
class DeleteTorrentInfoEvent extends TorrentInfoEvent {
  final String hash;
  final bool deleteFiles;

  DeleteTorrentInfoEvent({required this.hash, required this.deleteFiles});
}