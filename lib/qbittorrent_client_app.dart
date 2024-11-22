import 'package:flutter/material.dart';
import 'package:qbittorrent_client/screens/auth_screen/auth_screen.dart';

class QbittorrentClientApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthScreen(),
    );
  }
}