import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:qbittorrent_client/repositories/local_storage_repository.dart';
import 'package:qbittorrent_client/repositories/qbittorrent_web_api.dart';
import 'package:qbittorrent_client/screens/torrents_list_screen/torrents_list_screen.dart';

import 'widgets/auth_labled_textfield.dart';
import 'widgets/labeled_switch.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final addressEditingController = TextEditingController();
  final portEditingController = TextEditingController();
  final usernameEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  bool https = false;
  bool saveCredentials = false;

  final localStorageRepository = GetIt.I.get<LocalStorageRepository>();

  static const String _keyAddress = 'address';
  static const String _keyPort = 'port';
  static const String _keyHttps = 'https';
  static const String _keyUsername = 'username';
  static const String _keyPassword = 'password';

  Future<void> _loadCredentials() async {
    addressEditingController.text =
        await localStorageRepository.getString(_keyAddress) ?? '';
    portEditingController.text =
        await localStorageRepository.getString(_keyPort) ?? '';
    https = await localStorageRepository.getBool(_keyHttps) ?? false;
    usernameEditingController.text =
        await localStorageRepository.getString(_keyUsername) ?? '';
    passwordEditingController.text =
        await localStorageRepository.getString(_keyPassword) ?? '';
    setState(() {});
  }

  Future<void> _saveCredentials() async {
    await localStorageRepository.saveString(
        _keyAddress, addressEditingController.text);
    await localStorageRepository.saveString(
        _keyPort, portEditingController.text);
    await localStorageRepository.saveBool(_keyHttps, https);
    await localStorageRepository.saveString(
        _keyUsername, usernameEditingController.text);
    await localStorageRepository.saveString(
        _keyPassword, passwordEditingController.text);
  }

  Future<void> _tryRestoreSession() async {
    if(  await GetIt.I.get<QbittorrentWebApi>().tryRestoreSession()){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => TorrentsListScreen(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _tryRestoreSession();
    _loadCredentials();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
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
                    //color: Colors.purple,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Qbittorrent Client',
                    style: TextStyle(
                      //color: Colors.purple,
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
                    setState(() {
                      https = value;
                    });
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
            const SizedBox(height: 12),
            LabeledSwitch(
              label: 'Сохранить?',
              initialValue: saveCredentials,
              onChanged: (value) {
                setState(() {
                  saveCredentials = value;
                });
              },
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
                  if (saveCredentials) {
                    await _saveCredentials();
                  }
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TorrentsListScreen(),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                //backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 14.0),
                child: Text(
                  'Войти',
                  style: TextStyle(
                    //color: Colors.white,
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
