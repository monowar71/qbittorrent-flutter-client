part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;
  final String serverIp;
  final String serverPort;
  final bool isHTTPS;
  final bool isSaveCredentials;
  final bool isEnterAutomatically;

  LoginEvent({
    required this.username,
    required this.password,
    required this.serverIp,
    required this.serverPort,
    required this.isHTTPS,
    required this.isSaveCredentials,
    required this.isEnterAutomatically});

  @override
  List<Object?> get props => [username, password, serverIp, serverPort, isHTTPS, isSaveCredentials, isEnterAutomatically];
}

class TryRestoreLoginEvent extends AuthEvent {
  final String sid;

  TryRestoreLoginEvent({required this.sid});

  @override
  List<Object?> get props => [sid];
}
