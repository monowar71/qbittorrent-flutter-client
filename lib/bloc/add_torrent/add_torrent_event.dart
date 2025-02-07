part of 'add_torrent_bloc.dart';

abstract class AddTorrentEvent {}

class PickFileEvent extends AddTorrentEvent {}

class ClearFileEvent extends AddTorrentEvent {
  final AddedTorrentSettings settings;
  ClearFileEvent({required this.settings});
}

class UploadTorrentEvent extends AddTorrentEvent {
  final List<AddedTorrentSettings> settingsList;
  UploadTorrentEvent({required this.settingsList});
}
