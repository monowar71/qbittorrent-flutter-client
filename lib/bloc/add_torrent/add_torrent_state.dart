part of 'add_torrent_bloc.dart';

abstract class AddTorrentState {}

class AddTorrentInitial extends AddTorrentState {}

class FilesSelectedState extends AddTorrentState {
  final List<AddedTorrentSettings> settingsList;
  FilesSelectedState(this.settingsList);
}

class AddTorrentError extends AddTorrentState {
  final String message;
  AddTorrentError(this.message);
}

class AddTorrentSuccess extends AddTorrentState {}
