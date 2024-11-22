import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:qbittorrent_client/repositories/qbittorrent_web_api.dart';
import 'package:qbittorrent_client/screens/torrents_list_screen/torrents_list_screen.dart';

import 'widgets/auth_labled_textfield.dart';
import 'widgets/labeled_switch.dart';

class AuthScreen extends StatelessWidget {
  final addressEditingController = TextEditingController(text: '192.168.0.2');
  final portEditingController = TextEditingController(text: '8080');
  final usernameEditingController = TextEditingController(text: 'monowar71');
  final passwordEditingController = TextEditingController(text: 'a5B19tAo3');
  bool https = false;

  AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            Center(
              child: Column(
                children: [
                  Icon(
                    Icons.storage,
                    size: 100,
                    color: Colors.purple,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Qbittorrent Client',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            AuthLabeledTextfield(
              labelText: 'Server IP или DDNS',
              controller: addressEditingController,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: AuthLabeledTextfield(
                    labelText: 'Номер порта',
                    controller: portEditingController,
                  ),
                ),
                const SizedBox(width: 8),
                LabeledSwitch(
                  label: 'HTTPS',
                  initialValue: https,
                  onChanged: (value) {
                    https = value;
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            AuthLabeledTextfield(
              labelText: 'Имя пользователя',
              controller: usernameEditingController,
            ),
            const SizedBox(height: 12),
            AuthLabeledTextfield(
              labelText: 'Пароль',
              controller: passwordEditingController,
              obscureText: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                bool result = await GetIt.I.get<QbittorrentWebApi>().tryLogin(
                  address: addressEditingController.text,
                  port: portEditingController.text,
                  https: https,
                  username: usernameEditingController.text,
                  password: passwordEditingController.text,
                );
                if (result) {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                      TorrentsListScreen()));
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 14.0),
                child: Text(
                  'Войти',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}