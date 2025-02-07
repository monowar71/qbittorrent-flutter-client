part of 'torrent_file_info_bloc.dart';

abstract class TorrentFileInfoState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class TorrentFileInfoInitial extends TorrentFileInfoState {
  @override
  List<Object> get props => [];
}

class TorrentFileInfoLoading extends TorrentFileInfoState {}

class TorrentFileInfoLoaded extends TorrentFileInfoState {
  final List<FileInfo> fileInfos;
  TorrentFileInfoLoaded({required this.fileInfos});

  @override
  List<Object?> get props => [fileInfos];
}

class TorrentFileInfoError extends TorrentFileInfoState {
  final String error;
  TorrentFileInfoError({required this.error});

  @override
  List<Object?> get props => [error];
}
