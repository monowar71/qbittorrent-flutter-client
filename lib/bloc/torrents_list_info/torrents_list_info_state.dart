part of 'torrents_list_info_bloc.dart';

abstract class TorrentsListInfoState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TorrentsListInfoInitial extends TorrentsListInfoState {}

class TorrentsListInfoLoading extends TorrentsListInfoState {}

class TorrentsListInfoLoaded extends TorrentsListInfoState {
  final List<TorrentInfo> torrents;

  TorrentsListInfoLoaded({required this.torrents});

  @override
  List<Object?> get props => [torrents];
}

class TorrentListInfoError extends TorrentsListInfoState {
  final String error;

  TorrentListInfoError({required this.error});

  @override
  List<Object?> get props => [error];
}