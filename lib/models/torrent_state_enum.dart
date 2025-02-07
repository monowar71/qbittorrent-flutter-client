import 'package:qbittorrent_client/i18n/strings.g.dart';

enum TorrentState {
  error,
  missingFiles,
  uploading,
  pausedUP,
  stoppedUP,
  queuedUP,
  stalledUP,
  checkingUP,
  forcedUP,
  allocating,
  downloading,
  metaDL,
  stoppedDL,
  queuedDL,
  stalledDL,
  checkingDL,
  forcedDL,
  checkingResumeData,
  moving,
  unknown;

  static TorrentState fromJson(String value) {
    final entry = _enumToJson.entries.firstWhere(
          (entry) => entry.value == value,
      orElse: () {
        print("Неизвестное состояние: $value");
        return MapEntry(TorrentState.unknown, 'unknown');
      },
    );

    return entry.key;
  }

  static String toJson(TorrentState state) => _enumToJson[state] ?? 'unknown';

  @override
  String toString() {
    return _localizedNames[this] ?? 'Неизвестно';
  }

  static const Map<TorrentState, String> _enumToJson = {
    TorrentState.error: 'error',
    TorrentState.missingFiles: 'missingFiles',
    TorrentState.uploading: 'uploading',
    TorrentState.pausedUP: 'pausedUP',
    TorrentState.queuedUP: 'queuedUP',
    TorrentState.stalledUP: 'stalledUP',
    TorrentState.stoppedUP: 'stoppedUP',
    TorrentState.checkingUP: 'checkingUP',
    TorrentState.forcedUP: 'forcedUP',
    TorrentState.allocating: 'allocating',
    TorrentState.downloading: 'downloading',
    TorrentState.metaDL: 'metaDL',
    TorrentState.stoppedDL: 'stoppedDL',
    TorrentState.queuedDL: 'queuedDL',
    TorrentState.stalledDL: 'stalledDL',
    TorrentState.checkingDL: 'checkingDL',
    TorrentState.forcedDL: 'forcedDL',
    TorrentState.checkingResumeData: 'checkingResumeData',
    TorrentState.moving: 'moving',
    TorrentState.unknown: 'unknown',
  };

  static Map<TorrentState, String> _localizedNames = {
    TorrentState.error: t.models.torrent_state.error,
    TorrentState.missingFiles: t.models.torrent_state.missing_files,
    TorrentState.uploading: t.models.torrent_state.uploading,
    TorrentState.pausedUP: t.models.torrent_state.paused_up,
    TorrentState.queuedUP: t.models.torrent_state.queued_up,
    TorrentState.stalledUP: t.models.torrent_state.stalled_up,
    TorrentState.stoppedUP: t.models.torrent_state.stopped_up,
    TorrentState.checkingUP: t.models.torrent_state.checking_up,
    TorrentState.forcedUP: t.models.torrent_state.forced_up,
    TorrentState.allocating: t.models.torrent_state.allocating,
    TorrentState.downloading: t.models.torrent_state.downloading,
    TorrentState.metaDL: t.models.torrent_state.meta_dl,
    TorrentState.stoppedDL: t.models.torrent_state.stopped_dl,
    TorrentState.queuedDL: t.models.torrent_state.queued_dl,
    TorrentState.stalledDL: t.models.torrent_state.stalled_dl,
    TorrentState.checkingDL: t.models.torrent_state.checking_dl,
    TorrentState.forcedDL: t.models.torrent_state.forced_dl,
    TorrentState.checkingResumeData: t.models.torrent_state.checking_resume_data,
    TorrentState.moving: t.models.torrent_state.moving,
    TorrentState.unknown: t.models.torrent_state.unknown,
  };
}
