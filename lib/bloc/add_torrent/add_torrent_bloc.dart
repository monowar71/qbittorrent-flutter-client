import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qbittorrent_client/api/qbittorrent_api.dart';
import 'package:qbittorrent_client/models/added_torrent_settings.dart';

part 'add_torrent_event.dart';
part 'add_torrent_state.dart';

class AddTorrentBloc extends Bloc<AddTorrentEvent, AddTorrentState> {
  final QBittorrentApi api;

  AddTorrentBloc({required this.api}) : super(AddTorrentInitial()) {
    on<PickFileEvent>(_onPickFile);
    on<ClearFileEvent>(_onClearFile);
    on<UploadTorrentEvent>(_onUploadTorrents);
  }

  Future<void> _onPickFile(PickFileEvent event, Emitter<AddTorrentState> emit) async {
    try {
      final result = await FilePicker.platform.pickFiles(allowMultiple: true);
      if (result != null) {
        final selectedFiles = result.files
            .where((file) => file.path != null && file.path!.endsWith('.torrent'))
            .map((file) => AddedTorrentSettings(filePath: file.path!))
            .toList();

        if (selectedFiles.isEmpty) {
          emit(AddTorrentError("Можно выбрать только файлы .torrent"));
          return;
        }

        final currentState = state is FilesSelectedState ? (state as FilesSelectedState).settingsList : [];
        emit(FilesSelectedState([...currentState, ...selectedFiles]));
      }
    } catch (e) {
      emit(AddTorrentError("Ошибка выбора файла: $e"));
    }
  }

  void _onClearFile(ClearFileEvent event, Emitter<AddTorrentState> emit) {
    if (state is FilesSelectedState) {
      final currentList = (state as FilesSelectedState).settingsList;
      final updatedList = currentList.where((settings) => settings != event.settings).toList();
      emit(FilesSelectedState(updatedList));
    }
  }

  Future<void> _onUploadTorrents(UploadTorrentEvent event, Emitter<AddTorrentState> emit) async {
    try {
      for (var settings in event.settingsList) {
        await api.uploadTorrentFile(settings);
      }
      emit(AddTorrentSuccess());
    } catch (e) {
      emit(AddTorrentError("Ошибка загрузки файла: $e"));
    }
  }
}
