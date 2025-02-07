import 'package:qbittorrent_client/i18n/strings.g.dart';

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

  static Map<FilePriority, String> localizedNames = {
    FilePriority.dontDownload: t.models.file_priority.dont_download,
    FilePriority.normal: t.models.file_priority.normal,
    FilePriority.high: t.models.file_priority.high,
    FilePriority.maximal: t.models.file_priority.maximal,

  };
}