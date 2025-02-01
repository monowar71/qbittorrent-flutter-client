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
  pausedDL,
  queuedDL,
  stalledDL,
  checkingDL,
  forcedDL,
  checkingResumeData,
  moving,
  unknown;

  static TorrentState fromJson(String value) {
    return _enumToJson.entries
        .firstWhere((entry) => entry.value == value,
      orElse: () => MapEntry(TorrentState.unknown, 'unknown'),)
        .key;
  }

  static String toJson(TorrentState state) => _enumToJson[state] ?? 'unknown';

  String toLocalizedString() {
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
    TorrentState.pausedDL: 'pausedDL',
    TorrentState.queuedDL: 'queuedDL',
    TorrentState.stalledDL: 'stalledDL',
    TorrentState.checkingDL: 'checkingDL',
    TorrentState.forcedDL: 'forcedDL',
    TorrentState.checkingResumeData: 'checkingResumeData',
    TorrentState.moving: 'moving',
    TorrentState.unknown: 'unknown',
  };

  static const Map<TorrentState, String> _localizedNames = {
    TorrentState.error: 'Ошибка',
    TorrentState.missingFiles: 'Отсутствуют файлы',
    TorrentState.uploading: 'Раздача',
    TorrentState.pausedUP: 'Раздача приостановлена',
    TorrentState.queuedUP: 'В очереди на раздачу',
    TorrentState.stalledUP: 'Раздача остановлена',
    TorrentState.stoppedUP: 'Раздача остановлена',
    TorrentState.checkingUP: 'Проверка раздачи',
    TorrentState.forcedUP: 'Принудительная раздача',
    TorrentState.allocating: 'Выделение места',
    TorrentState.downloading: 'Загрузка',
    TorrentState.metaDL: 'Загрузка метаданных',
    TorrentState.pausedDL: 'Загрузка приостановлена',
    TorrentState.queuedDL: 'В очереди на загрузку',
    TorrentState.stalledDL: 'Загрузка остановлена',
    TorrentState.checkingDL: 'Проверка загрузки',
    TorrentState.forcedDL: 'Принудительная загрузка',
    TorrentState.checkingResumeData: 'Проверка данных',
    TorrentState.moving: 'Перемещение файлов',
    TorrentState.unknown: 'Неизвестный статус',
  };
}
