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

  LoginEvent({
    required this.username,
    required this.password,
    required this.serverIp,
    required this.serverPort,
    required this.isHTTPS,
    required this.isSaveCredentials});

  @override
  List<Object?> get props => [username, password, serverIp, serverPort, isHTTPS, isSaveCredentials];
}

class TryRestoreLoginEvent extends AuthEvent {
  final String sid;

  TryRestoreLoginEvent({required this.sid});

  @override
  List<Object?> get props => [sid];
}
