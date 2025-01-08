import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:qbittorrent_client/repositories/local_storage_repository.dart';
import 'package:qbittorrent_client/repositories/qbittorrent_web_api.dart';

// Events
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthLoadCredentialsEvent extends AuthEvent {}

class AuthToggleHttpsEvent extends AuthEvent {
  final bool isHttps;

  const AuthToggleHttpsEvent(this.isHttps);

  @override
  List<Object?> get props => [isHttps];
}

class AuthToggleSaveCredentialsEvent extends AuthEvent {
  final bool saveCredentials;

  const AuthToggleSaveCredentialsEvent(this.saveCredentials);

  @override
  List<Object?> get props => [saveCredentials];
}

class AuthSubmitEvent extends AuthEvent {}

// States
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccessState extends AuthState {}

class AuthErrorState extends AuthState {
  final String message;

  const AuthErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

// Bloc
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LocalStorageRepository localStorageRepository;
  final QbittorrentWebApi qbittorrentWebApi;

  // Controllers for TextFields
  final TextEditingController addressController = TextEditingController();
  final TextEditingController portController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool https = false;
  bool saveCredentials = false;

  AuthBloc({
    required this.localStorageRepository,
    required this.qbittorrentWebApi,
  }) : super(AuthInitialState()) {
    on<AuthLoadCredentialsEvent>(_onLoadCredentials);
    on<AuthToggleHttpsEvent>(_onToggleHttps);
    on<AuthToggleSaveCredentialsEvent>(_onToggleSaveCredentials);
    on<AuthSubmitEvent>(_onSubmit);
  }

  Future<void> _onLoadCredentials(
      AuthLoadCredentialsEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      addressController.text =
          await localStorageRepository.getString('address') ?? '';
      portController.text =
          await localStorageRepository.getString('port') ?? '';
      https = await localStorageRepository.getBool('https') ?? false;
      usernameController.text =
          await localStorageRepository.getString('username') ?? '';
      passwordController.text =
          await localStorageRepository.getString('password') ?? '';
      saveCredentials = true; // Load credentials only if they exist
      emit(AuthInitialState());
    } catch (e) {
      emit(AuthErrorState('Ошибка при загрузке сохраненных данных'));
    }
  }

  void _onToggleHttps(AuthToggleHttpsEvent event, Emitter<AuthState> emit) {
    https = event.isHttps;
    emit(AuthInitialState());
  }

  void _onToggleSaveCredentials(
      AuthToggleSaveCredentialsEvent event, Emitter<AuthState> emit) {
    saveCredentials = event.saveCredentials;
    emit(AuthInitialState());
  }

  Future<void> _onSubmit(AuthSubmitEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      bool loginResult = await qbittorrentWebApi.tryLogin(
        address: addressController.text,
        port: portController.text,
        https: https,
        username: usernameController.text,
        password: passwordController.text,
      );

      if (loginResult) {
        if (saveCredentials) {
          await localStorageRepository.saveString(
              'address', addressController.text);
          await localStorageRepository.saveString(
              'port', portController.text);
          await localStorageRepository.saveBool('https', https);
          await localStorageRepository.saveString(
              'username', usernameController.text);
          await localStorageRepository.saveString(
              'password', passwordController.text);
        }
        emit(AuthSuccessState());
      } else {
        emit(AuthErrorState('Неверные учетные данные'));
      }
    } catch (e) {
      emit(AuthErrorState('Ошибка при подключении: ${e.toString()}'));
    }
  }

  @override
  Future<void> close() {
    addressController.dispose();
    portController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
