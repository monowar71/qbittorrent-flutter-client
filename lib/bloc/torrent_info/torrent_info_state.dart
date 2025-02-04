part of 'torrent_info_bloc.dart';

abstract class TorrentInfoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TorrentInfoInitial extends TorrentInfoState {}

class TorrentInfoLoading extends TorrentInfoState {}

class TorrentInfoLoaded extends TorrentInfoState {
  final TorrentInfo torrentInfo;

  TorrentInfoLoaded({required this.torrentInfo});

  @override
  List<Object?> get props => [torrentInfo];
}

class TorrentInfoDeleted extends TorrentInfoState {}

class TorrentInfoError extends TorrentInfoState {
  final String error;

  TorrentInfoError({required this.error});

  @override
  List<Object?> get props => [error];
}