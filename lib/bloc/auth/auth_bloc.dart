import 'package:bloc/bloc.dart' show Bloc, Emitter;
import 'package:equatable/equatable.dart';
import 'package:qbittorrent_client/api/qbittorrent_api.dart';
import 'package:qbittorrent_client/consts.dart';
import 'package:qbittorrent_client/repositories/local_storage_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final QBittorrentApi api;
  final LocalStorageRepository localStorageRepository;

  AuthBloc({required this.api, required this.localStorageRepository}) : super(AuthInitial()) {
    on<LoginEvent>(_onLoginEvent);
  }

  Future<void> _onLoginEvent(
      LoginEvent event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());
    try {
      if(event.isSaveCredentials){
        await localStorageRepository.saveString(
            Consts.keyAddress, event.serverIp);
        await localStorageRepository.saveString(
            Consts.keyPort, event.serverPort);
        await localStorageRepository.saveBool(Consts.keyHttps, event.isHTTPS);
        await localStorageRepository.saveString(
            Consts.keyUsername, event.username);
        await localStorageRepository.saveString(
            Consts.keyPassword, event.password);
        await localStorageRepository.saveBool(
          Consts.keySaveCredentials, event.isSaveCredentials);
        await localStorageRepository.saveBool(
          Consts.keyEnterAutomatically, event.isEnterAutomatically);
      }
      await api.login(
          address: event.serverIp,
          port: event.serverPort,
          isHTTPS: event.isHTTPS,
          username: event.username,
          password: event.password);

      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }
}