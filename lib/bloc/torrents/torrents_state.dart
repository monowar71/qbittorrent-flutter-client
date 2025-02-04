part of 'torrents_bloc.dart';

abstract class TorrentsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TorrentInitial extends TorrentsState {}

class TorrentInfoLoading extends TorrentsState {}

class TorrentsListInfoLoaded extends TorrentsState {
  final List<TorrentInfo> torrents;

  TorrentsListInfoLoaded({required this.torrents});

  @override
  List<Object?> get props => [torrents];
}

class TorrentInfoLoaded extends TorrentsState {
  final TorrentInfo torrentInfo;

  TorrentInfoLoaded({required this.torrentInfo});

  @override
  List<Object?> get props => [torrentInfo];
}

class TorrentInfoDeleted extends TorrentsState {}

class TorrentsError extends TorrentsState {
  final String error;

  TorrentsError({required this.error});

  @override
  List<Object?> get props => [error];
}