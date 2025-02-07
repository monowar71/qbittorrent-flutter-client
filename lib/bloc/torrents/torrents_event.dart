part of 'torrents_bloc.dart';

abstract class TorrentsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchTorrentsListEvent extends TorrentsEvent {}

class FetchTorrentInfoEvent extends TorrentsEvent {
  final String hash;

  FetchTorrentInfoEvent({required this.hash});
}

class ResumeTorrentEvent extends TorrentsEvent {
  final String hash;

  ResumeTorrentEvent({required this.hash});
}

class PauseTorrentEvent extends TorrentsEvent {
  final String hash;

  PauseTorrentEvent({required this.hash});
}
class DeleteTorrentEvent extends TorrentsEvent {
  final String hash;
  final bool deleteFiles;

  DeleteTorrentEvent({required this.hash, required this.deleteFiles});
}