part of 'torrent_file_info_bloc.dart';

sealed class TorrentFileInfoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}
class FetchTorrentFileInfoEvent extends TorrentFileInfoEvent {
  final String hash;

  FetchTorrentFileInfoEvent({required this.hash});
}

class RenameTorrentFileEvent extends TorrentFileInfoEvent {
  final String hash;
  final String oldName;
  final String newName;

  RenameTorrentFileEvent({required this.hash, required this.oldName, required this.newName});
}
class SetFilePriorityEvent extends TorrentFileInfoEvent {
  final String hash;
  final String fileId;
  final int priority;

  SetFilePriorityEvent({required this.hash, required this.fileId, required this.priority});

}
