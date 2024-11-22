String? extractSID(String cookie) {
  final regex = RegExp(r'SID=([^;]+)');
  final match = regex.firstMatch(cookie);
  return match?.group(1);
}
String convertHashesToString(List<String> hashes) {
  if (hashes.isEmpty) {
    return 'all'; // Если список пуст, возвращаем "all"
  } else if (hashes.length == 1){
      return hashes.first; // Если список не пуст, возвращаем первый элемент списка
  }
    else {
      return hashes.join('|');
  }// Объединяем элементы списка через "|"
}

String formatBytes(int bytes) {
  const int kilobyte = 1024;
  const int megabyte = kilobyte * 1024;
  const int gigabyte = megabyte * 1024;
  const int terabyte = gigabyte * 1024;

  if (bytes < kilobyte) {
    return "$bytes B"; // байты
  } else if (bytes < megabyte) {
    return "${(bytes / kilobyte).toStringAsFixed(2)} KB"; // килобайты
  } else if (bytes < gigabyte) {
    return "${(bytes / megabyte).toStringAsFixed(2)} MB"; // мегабайты
  } else if (bytes < terabyte) {
    return "${(bytes / gigabyte).toStringAsFixed(2)} GB"; // гигабайты
  } else {
    return "${(bytes / terabyte).toStringAsFixed(2)} TB"; // терабайты
  }
}

String formatSpeed(int bytesPerSecond) {
  const int kilobyte = 1024;
  const int megabyte = kilobyte * 1024;
  const int gigabyte = megabyte * 1024;

  if (bytesPerSecond < kilobyte) {
    return "$bytesPerSecond B/s"; // байты в секунду
  } else if (bytesPerSecond < megabyte) {
    return "${(bytesPerSecond / kilobyte).toStringAsFixed(2)} KB/s"; // килобайты в секунду
  } else if (bytesPerSecond < gigabyte) {
    return "${(bytesPerSecond / megabyte).toStringAsFixed(2)} MB/s"; // мегабайты в секунду
  } else {
    return "${(bytesPerSecond / gigabyte).toStringAsFixed(2)} GB/s"; // гигабайты в секунду
  }
}
