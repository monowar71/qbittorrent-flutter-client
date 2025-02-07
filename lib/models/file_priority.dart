enum FilePriority {
  dontDownload,
  normal,
  high,
  maximal;


  static const Map<FilePriority, int> enumToJson = {
    FilePriority.dontDownload: 0,
    FilePriority.normal: 1,
    FilePriority.high: 6,
    FilePriority.maximal: 7
  };

  static FilePriority fromJson(int value) {
    final entry = enumToJson.entries.firstWhere(
            (entry) => entry.value == value);

    return entry.key;
  }

  static int toJson(FilePriority state) => enumToJson[state] ?? 1;

  @override
  String toString() {
    return localizedNames[this] ?? 'Неизвестно';
  }

  int? toInt(){
    return enumToJson[this];
  }

  static const Map<FilePriority, String> localizedNames = {
    FilePriority.dontDownload: 'Не загружать',
    FilePriority.normal: 'Нормальный',
    FilePriority.high: 'Высокий',
    FilePriority.maximal: 'Максимальный'

  };
}