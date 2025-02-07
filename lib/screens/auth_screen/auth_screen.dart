import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:qbittorrent_client/bloc/auth/auth_bloc.dart';
import 'package:qbittorrent_client/consts.dart';
import 'package:qbittorrent_client/i18n/strings.g.dart';
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
  bool enterAutomatically = false;

  void _tryGetStoringCredentials() async {
      enterAutomatically = await localStorageRepository.getBool(Consts.keyEnterAutomatically) ?? false;
      saveCredentials = await localStorageRepository.getBool(Consts.keySaveCredentials) ?? false;

      addressEditingController.text =
          await localStorageRepository.getString(Consts.keyAddress) ?? '';
      portEditingController.text =
          await localStorageRepository.getString(Consts.keyPort) ?? '8080';
      https = await localStorageRepository.getBool(Consts.keyHttps) ?? false;
      usernameEditingController.text =
          await localStorageRepository.getString(Consts.keyUsername) ?? '';
      passwordEditingController.text =
          await localStorageRepository.getString(Consts.keyPassword) ?? '';

      if(enterAutomatically &&
          addressEditingController.text.isNotEmpty &&
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
              isEnterAutomatically: enterAutomatically,
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
                      Text(t.auth_screen.title,
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
                  labelText: t.auth_screen.server_ip_or_dns,
                  controller: addressEditingController,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: AuthLabeledTextfield(
                        labelText: t.auth_screen.port_number,
                        controller: portEditingController,
                      ),
                    ),
                    const SizedBox(width: 8),
                    LabeledSwitch(
                      label: t.auth_screen.https,
                      initialValue: https,
                      onChanged: (value) {
                        https = value;
                        },
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                AuthLabeledTextfield(
                  labelText: t.auth_screen.username,
                  controller: usernameEditingController,
                ),
                const SizedBox(height: 12),
                AuthLabeledTextfield(
                  labelText: t.auth_screen.password,
                  controller: passwordEditingController,
                  obscureText: true,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LabeledSwitch(
                      label: t.auth_screen.save_credentials,
                      initialValue: saveCredentials,
                      onChanged: (value) {
                        setState(() {
                          saveCredentials = value;
                        });
                        },
                    ),
                    if (saveCredentials)
                      LabeledSwitch(
                        label: t.auth_screen.enter_automatically,
                        initialValue: enterAutomatically,
                        onChanged: (value) {
                          enterAutomatically = value;
                        },
                      ),
                  ],
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
                          isEnterAutomatically: enterAutomatically,
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 14.0),
                    child: Text(t.auth_screen.enter,
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
