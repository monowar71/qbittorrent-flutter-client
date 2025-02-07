import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:qbittorrent_client/bloc/auth/auth_bloc.dart';
import 'package:qbittorrent_client/consts.dart';
import 'package:qbittorrent_client/repositories/local_storage_repository.dart';
import 'package:qbittorrent_client/screens/auth_screen/widgets/auth_labled_textfield.dart';
import 'package:qbittorrent_client/screens/auth_screen/widgets/labeled_switch.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final localStorageRepository = GetIt.I<LocalStorageRepository>();

  final addressEditingController = TextEditingController();
  final portEditingController = TextEditingController();
  final usernameEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  bool https = false;
  bool saveCredentials = false;

  void _tryGetStoringCredentials() async {
      addressEditingController.text =
          await localStorageRepository.getString(Consts.keyAddress) ?? '';
      portEditingController.text =
          await localStorageRepository.getString(Consts.keyPort) ?? '8080';
      https = await localStorageRepository.getBool(Consts.keyHttps) ?? false;
      usernameEditingController.text =
          await localStorageRepository.getString(Consts.keyUsername) ?? '';
      passwordEditingController.text =
          await localStorageRepository.getString(Consts.keyPassword) ?? '';

      if(addressEditingController.text.isNotEmpty &&
          portEditingController.text.isNotEmpty &&
          usernameEditingController.text.isNotEmpty &&
          passwordEditingController.text.isNotEmpty)
      {
        if (!mounted) return;

        context.read<AuthBloc>().add(
            LoginEvent(
              username: usernameEditingController.text,
              password: passwordEditingController.text,
              serverIp: addressEditingController.text,
              serverPort: portEditingController.text,
              isHTTPS: https,
              isSaveCredentials: saveCredentials,
            ));
      }

      setState(() {}
    );
  }
  @override
  void initState() {
    super.initState();

    _tryGetStoringCredentials();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacementNamed(context, '/torrents');
          }
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(child: const CircularProgressIndicator());
          }
          return Padding(
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
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Qbittorrent Client',
                        style: TextStyle(
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
                const SizedBox(height: 12),
                LabeledSwitch(
                  label: 'Сохранить?',
                  initialValue: saveCredentials,
                  onChanged: (value) {
                    saveCredentials = value;
                    },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                        LoginEvent(
                          username: usernameEditingController.text,
                          password: passwordEditingController.text,
                          serverIp: addressEditingController.text,
                          serverPort: portEditingController.text,
                          isHTTPS: https,
                          isSaveCredentials: saveCredentials,
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14.0),
                    child: Text('Войти',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          );
        },
      ),
    );
  }
}
