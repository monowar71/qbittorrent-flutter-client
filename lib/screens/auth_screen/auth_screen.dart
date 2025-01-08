import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:qbittorrent_client/repositories/local_storage_repository.dart';
import 'package:qbittorrent_client/repositories/qbittorrent_web_api.dart';
import 'package:qbittorrent_client/screens/auth_screen/bloc/auth_bloc.dart';
import 'package:qbittorrent_client/screens/torrents_list_screen/torrents_list_screen.dart';

import 'widgets/auth_labled_textfield.dart';
import 'widgets/labeled_switch.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(
        localStorageRepository: GetIt.I.get<LocalStorageRepository>(),
        qbittorrentWebApi: GetIt.I.get<QbittorrentWebApi>(),
      )..add(AuthLoadCredentialsEvent()),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccessState) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TorrentsListScreen(),
                  ),
                );
              } else if (state is AuthErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              }
            },
            builder: (context, state) {
              if (state is AuthLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }

              final bloc = context.read<AuthBloc>();
              return Column(
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
                    controller: bloc.addressController,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: AuthLabeledTextfield(
                          labelText: 'Номер порта',
                          controller: bloc.portController,
                        ),
                      ),
                      const SizedBox(width: 8),
                      LabeledSwitch(
                        label: 'HTTPS',
                        initialValue: bloc.https,
                        onChanged: (value) => bloc.add(AuthToggleHttpsEvent(value)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  AuthLabeledTextfield(
                    labelText: 'Имя пользователя',
                    controller: bloc.usernameController,
                  ),
                  const SizedBox(height: 12),
                  AuthLabeledTextfield(
                    labelText: 'Пароль',
                    controller: bloc.passwordController,
                    obscureText: true,
                  ),
                  const SizedBox(height: 12),
                  LabeledSwitch(
                    label: 'Сохранить?',
                    initialValue: bloc.saveCredentials,
                    onChanged: (value) => bloc.add(AuthToggleSaveCredentialsEvent(value)),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      bloc.add(AuthSubmitEvent());
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 14.0),
                      child: Text(
                        'Войти',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
