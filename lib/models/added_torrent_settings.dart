class AddedTorrentSettings{
  final String filePath;
  String? savePath;
  bool paused = false;
  bool skipChecking = false;
  String? rename;

  AddedTorrentSettings({
    required this.filePath,
  });
}
