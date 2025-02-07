String? extractSID(String cookie) {
  final regex = RegExp(r'SID=([^;]+)');
  final match = regex.firstMatch(cookie);
  return match?.group(1);
}
String convertHashesToString(List<String> hashes) {
  if (hashes.isEmpty) {
    return '';
  } else if (hashes.length == 1){
      return hashes.first;
  }
    else {
      return hashes.join('|');
  }
}

String formatBytes(int bytes) {
  const int kilobyte = 1024;
  const int megabyte = kilobyte * 1024;
  const int gigabyte = megabyte * 1024;
  const int terabyte = gigabyte * 1024;

  if (bytes < kilobyte) {
    return "$bytes B"; // байты
  } else if (bytes < megabyte) {
    return "${(bytes / kilobyte).toStringAsFixed(2)} KB";
  } else if (bytes < gigabyte) {
    return "${(bytes / megabyte).toStringAsFixed(2)} MB";
  } else if (bytes < terabyte) {
    return "${(bytes / gigabyte).toStringAsFixed(2)} GB";
  } else {
    return "${(bytes / terabyte).toStringAsFixed(2)} TB";
  }
}

String formatSpeed(int bytesPerSecond) {
  const int kilobyte = 1024;
  const int megabyte = kilobyte * 1024;
  const int gigabyte = megabyte * 1024;

  if (bytesPerSecond < kilobyte) {
    return "$bytesPerSecond B/s"; // байты в секунду
  } else if (bytesPerSecond < megabyte) {
    return "${(bytesPerSecond / kilobyte).toStringAsFixed(2)} KB/s";
  } else if (bytesPerSecond < gigabyte) {
    return "${(bytesPerSecond / megabyte).toStringAsFixed(2)} MB/s";
  } else {
    return "${(bytesPerSecond / gigabyte).toStringAsFixed(2)} GB/s";
  }
}
