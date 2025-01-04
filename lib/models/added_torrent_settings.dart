class AddedTorrentSettings{
  final String filePath;
  final String? savePath;
  bool paused = false;
  bool skipChecking = false;
  final String? rename;

  AddedTorrentSettings({
    required this.filePath,
    this.savePath,
    this.rename,
  });
}
