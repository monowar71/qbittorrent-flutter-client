///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsRu implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsRu({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.ru,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ru>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsRu _root = this; // ignore: unused_field

	// Translations
	@override late final _TranslationsAuthScreenRu auth_screen = _TranslationsAuthScreenRu._(_root);
	@override late final _TranslationsTorrentListScreenRu torrent_list_screen = _TranslationsTorrentListScreenRu._(_root);
	@override late final _TranslationsTorrentCardScreenRu torrent_card_screen = _TranslationsTorrentCardScreenRu._(_root);
	@override late final _TranslationsAddTorrentScreenRu add_torrent_screen = _TranslationsAddTorrentScreenRu._(_root);
	@override late final _TranslationsModelsRu models = _TranslationsModelsRu._(_root);
}

// Path: auth_screen
class _TranslationsAuthScreenRu implements TranslationsAuthScreenEn {
	_TranslationsAuthScreenRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Qbittorrent Client';
	@override String get server_ip_or_dns => 'Server IP или DDNS';
	@override String get port_number => 'Номер порта';
	@override String get https => 'HTTPS';
	@override String get username => 'Имя пользователя';
	@override String get password => 'Пароль';
	@override String get save_credentials => 'Сохранить?';
	@override String get enter_automatically => 'Входить автоматически?';
	@override String get enter => 'Войти';
}

// Path: torrent_list_screen
class _TranslationsTorrentListScreenRu implements TranslationsTorrentListScreenEn {
	_TranslationsTorrentListScreenRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Список торрентов';
	@override String get loading_torrents => 'Загрузка торрентов...';
	@override String get torrents_error => 'Ошибка загрузки торрентов {error}';
	@override String get no_active_torrents => 'Нет активных торрентов';
}

// Path: torrent_card_screen
class _TranslationsTorrentCardScreenRu implements TranslationsTorrentCardScreenEn {
	_TranslationsTorrentCardScreenRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Детали торрента';
	@override String get base_info_tab_label => 'Основные';
	@override String get files_info_tab_label => 'Файлы';
	@override late final _TranslationsTorrentCardScreenBaseInfoTabRu base_info_tab = _TranslationsTorrentCardScreenBaseInfoTabRu._(_root);
	@override late final _TranslationsTorrentCardScreenFilesInfoTabRu files_info_tab = _TranslationsTorrentCardScreenFilesInfoTabRu._(_root);
}

// Path: add_torrent_screen
class _TranslationsAddTorrentScreenRu implements TranslationsAddTorrentScreenEn {
	_TranslationsAddTorrentScreenRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Добавить торрент';
	@override String get add_all_button => 'Добавить все';
	@override late final _TranslationsAddTorrentScreenFilePickerSectionRu file_picker_section = _TranslationsAddTorrentScreenFilePickerSectionRu._(_root);
	@override late final _TranslationsAddTorrentScreenTorrentCardRu torrent_card = _TranslationsAddTorrentScreenTorrentCardRu._(_root);
}

// Path: models
class _TranslationsModelsRu implements TranslationsModelsEn {
	_TranslationsModelsRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsModelsTorrentStateRu torrent_state = _TranslationsModelsTorrentStateRu._(_root);
	@override late final _TranslationsModelsFilePriorityRu file_priority = _TranslationsModelsFilePriorityRu._(_root);
}

// Path: torrent_card_screen.base_info_tab
class _TranslationsTorrentCardScreenBaseInfoTabRu implements TranslationsTorrentCardScreenBaseInfoTabEn {
	_TranslationsTorrentCardScreenBaseInfoTabRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get main_info_label => 'Основная информация';
	@override String get hash_label => 'Хеш';
	@override String get status_label => 'Статус';
	@override String get name_label => 'Имя';
	@override String get tags_label => 'Тег';
	@override String get category_label => 'Категория';
	@override String get magnet_uri_label => 'Магнет-ссылка';
	@override String get save_path_label => 'Адрес сохранения';
	@override String get seeds_peers_section_title => 'Сиды/пиры';
	@override String get speed_section_title => 'Скорость';
	@override String get actions_section_title => 'Действия';
	@override late final _TranslationsTorrentCardScreenBaseInfoTabTorrentActionsButtonsRu torrent_actions_buttons = _TranslationsTorrentCardScreenBaseInfoTabTorrentActionsButtonsRu._(_root);
	@override late final _TranslationsTorrentCardScreenBaseInfoTabFileSizeInfoRu file_size_info = _TranslationsTorrentCardScreenBaseInfoTabFileSizeInfoRu._(_root);
	@override late final _TranslationsTorrentCardScreenBaseInfoTabSeedPeersInfoRu seed_peers_info = _TranslationsTorrentCardScreenBaseInfoTabSeedPeersInfoRu._(_root);
}

// Path: torrent_card_screen.files_info_tab
class _TranslationsTorrentCardScreenFilesInfoTabRu implements TranslationsTorrentCardScreenFilesInfoTabEn {
	_TranslationsTorrentCardScreenFilesInfoTabRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsTorrentCardScreenFilesInfoTabFileCardRu file_card = _TranslationsTorrentCardScreenFilesInfoTabFileCardRu._(_root);
	@override late final _TranslationsTorrentCardScreenFilesInfoTabFileSettingsDialogRu file_settings_dialog = _TranslationsTorrentCardScreenFilesInfoTabFileSettingsDialogRu._(_root);
}

// Path: add_torrent_screen.file_picker_section
class _TranslationsAddTorrentScreenFilePickerSectionRu implements TranslationsAddTorrentScreenFilePickerSectionEn {
	_TranslationsAddTorrentScreenFilePickerSectionRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get add_files_button_label => 'Добавить файлы';
}

// Path: add_torrent_screen.torrent_card
class _TranslationsAddTorrentScreenTorrentCardRu implements TranslationsAddTorrentScreenTorrentCardEn {
	_TranslationsAddTorrentScreenTorrentCardRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get pause_at_start_label => 'Пауза при старте';
	@override String get skip_checking_label => 'Пропустить проверку';
}

// Path: models.torrent_state
class _TranslationsModelsTorrentStateRu implements TranslationsModelsTorrentStateEn {
	_TranslationsModelsTorrentStateRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get error => 'Ошибка';
	@override String get missing_files => 'Отсутствуют файлы';
	@override String get uploading => 'Раздача';
	@override String get paused_up => 'Раздача приостановлена';
	@override String get queued_up => 'В очереди на раздачу';
	@override String get stalled_up => 'Раздача остановлена';
	@override String get stopped_up => 'Раздача остановлена';
	@override String get checking_up => 'Проверка раздачи';
	@override String get forced_up => 'Принудительная раздача';
	@override String get allocating => 'Выделение места';
	@override String get downloading => 'Загрузка';
	@override String get meta_dl => 'Загрузка метаданных';
	@override String get stopped_dl => 'Загрузка приостановлена';
	@override String get queued_dl => 'В очереди на загрузку';
	@override String get stalled_dl => 'Загрузка остановлена';
	@override String get checking_dl => 'Проверка загрузки';
	@override String get forced_dl => 'Принудительная загрузка';
	@override String get checking_resume_data => 'Проверка данных';
	@override String get moving => 'Перемещение файлов';
	@override String get unknown => 'Неизвестный статус';
}

// Path: models.file_priority
class _TranslationsModelsFilePriorityRu implements TranslationsModelsFilePriorityEn {
	_TranslationsModelsFilePriorityRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get dont_download => 'Не загружать';
	@override String get normal => 'Нормальный';
	@override String get high => 'Высокий';
	@override String get maximal => 'Максимальный';
}

// Path: torrent_card_screen.base_info_tab.torrent_actions_buttons
class _TranslationsTorrentCardScreenBaseInfoTabTorrentActionsButtonsRu implements TranslationsTorrentCardScreenBaseInfoTabTorrentActionsButtonsEn {
	_TranslationsTorrentCardScreenBaseInfoTabTorrentActionsButtonsRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get resume_button => 'Запустить';
	@override String get pause_button => 'Остановить';
	@override String get delete_button => 'Удалить';
	@override String get delete_confirmation_title => 'Удаление торрента';
	@override String get delete_confirmation_message => 'Как вы хотите удалить?';
	@override String get delete_only_torrent => 'Только торрент';
	@override String get delete_torrent_and_files => 'Торрент и файлы';
	@override String get cancel_button => 'Отмена';
}

// Path: torrent_card_screen.base_info_tab.file_size_info
class _TranslationsTorrentCardScreenBaseInfoTabFileSizeInfoRu implements TranslationsTorrentCardScreenBaseInfoTabFileSizeInfoEn {
	_TranslationsTorrentCardScreenBaseInfoTabFileSizeInfoRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get total_size_label => 'Общий размер';
	@override String get ratio_label => 'Соотношение';
	@override String get completed_size_label => 'Уже скачанно';
	@override String get remaining_size_label => 'Осталось скачать';
}

// Path: torrent_card_screen.base_info_tab.seed_peers_info
class _TranslationsTorrentCardScreenBaseInfoTabSeedPeersInfoRu implements TranslationsTorrentCardScreenBaseInfoTabSeedPeersInfoEn {
	_TranslationsTorrentCardScreenBaseInfoTabSeedPeersInfoRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get seeds_label => 'Seeds:';
	@override String get peers_label => 'Peers:';
}

// Path: torrent_card_screen.files_info_tab.file_card
class _TranslationsTorrentCardScreenFilesInfoTabFileCardRu implements TranslationsTorrentCardScreenFilesInfoTabFileCardEn {
	_TranslationsTorrentCardScreenFilesInfoTabFileCardRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get size_label => 'Размер';
	@override String get priority_label => 'Приоритет';
	@override String get progress_label => 'Прогресс';
	@override String get seeding_label => 'Сидируется';
	@override String get available_label => 'Доступно';
	@override String get yes => 'Да';
	@override String get no => 'Нет';
}

// Path: torrent_card_screen.files_info_tab.file_settings_dialog
class _TranslationsTorrentCardScreenFilesInfoTabFileSettingsDialogRu implements TranslationsTorrentCardScreenFilesInfoTabFileSettingsDialogEn {
	_TranslationsTorrentCardScreenFilesInfoTabFileSettingsDialogRu._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Настройки файла';
	@override String get name_label => 'Название файла';
	@override String get priority_label => 'Приоритет';
	@override String get unknown => 'Неизвестно';
	@override String get cancel_button => 'Отмена';
	@override String get confirm_button => 'Подтвердить';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsRu {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'auth_screen.title': return 'Qbittorrent Client';
			case 'auth_screen.server_ip_or_dns': return 'Server IP или DDNS';
			case 'auth_screen.port_number': return 'Номер порта';
			case 'auth_screen.https': return 'HTTPS';
			case 'auth_screen.username': return 'Имя пользователя';
			case 'auth_screen.password': return 'Пароль';
			case 'auth_screen.save_credentials': return 'Сохранить?';
			case 'auth_screen.enter_automatically': return 'Входить автоматически?';
			case 'auth_screen.enter': return 'Войти';
			case 'torrent_list_screen.title': return 'Список торрентов';
			case 'torrent_list_screen.loading_torrents': return 'Загрузка торрентов...';
			case 'torrent_list_screen.torrents_error': return 'Ошибка загрузки торрентов {error}';
			case 'torrent_list_screen.no_active_torrents': return 'Нет активных торрентов';
			case 'torrent_card_screen.title': return 'Детали торрента';
			case 'torrent_card_screen.base_info_tab_label': return 'Основные';
			case 'torrent_card_screen.files_info_tab_label': return 'Файлы';
			case 'torrent_card_screen.base_info_tab.main_info_label': return 'Основная информация';
			case 'torrent_card_screen.base_info_tab.hash_label': return 'Хеш';
			case 'torrent_card_screen.base_info_tab.status_label': return 'Статус';
			case 'torrent_card_screen.base_info_tab.name_label': return 'Имя';
			case 'torrent_card_screen.base_info_tab.tags_label': return 'Тег';
			case 'torrent_card_screen.base_info_tab.category_label': return 'Категория';
			case 'torrent_card_screen.base_info_tab.magnet_uri_label': return 'Магнет-ссылка';
			case 'torrent_card_screen.base_info_tab.save_path_label': return 'Адрес сохранения';
			case 'torrent_card_screen.base_info_tab.seeds_peers_section_title': return 'Сиды/пиры';
			case 'torrent_card_screen.base_info_tab.speed_section_title': return 'Скорость';
			case 'torrent_card_screen.base_info_tab.actions_section_title': return 'Действия';
			case 'torrent_card_screen.base_info_tab.torrent_actions_buttons.resume_button': return 'Запустить';
			case 'torrent_card_screen.base_info_tab.torrent_actions_buttons.pause_button': return 'Остановить';
			case 'torrent_card_screen.base_info_tab.torrent_actions_buttons.delete_button': return 'Удалить';
			case 'torrent_card_screen.base_info_tab.torrent_actions_buttons.delete_confirmation_title': return 'Удаление торрента';
			case 'torrent_card_screen.base_info_tab.torrent_actions_buttons.delete_confirmation_message': return 'Как вы хотите удалить?';
			case 'torrent_card_screen.base_info_tab.torrent_actions_buttons.delete_only_torrent': return 'Только торрент';
			case 'torrent_card_screen.base_info_tab.torrent_actions_buttons.delete_torrent_and_files': return 'Торрент и файлы';
			case 'torrent_card_screen.base_info_tab.torrent_actions_buttons.cancel_button': return 'Отмена';
			case 'torrent_card_screen.base_info_tab.file_size_info.total_size_label': return 'Общий размер';
			case 'torrent_card_screen.base_info_tab.file_size_info.ratio_label': return 'Соотношение';
			case 'torrent_card_screen.base_info_tab.file_size_info.completed_size_label': return 'Уже скачанно';
			case 'torrent_card_screen.base_info_tab.file_size_info.remaining_size_label': return 'Осталось скачать';
			case 'torrent_card_screen.base_info_tab.seed_peers_info.seeds_label': return 'Seeds:';
			case 'torrent_card_screen.base_info_tab.seed_peers_info.peers_label': return 'Peers:';
			case 'torrent_card_screen.files_info_tab.file_card.size_label': return 'Размер';
			case 'torrent_card_screen.files_info_tab.file_card.priority_label': return 'Приоритет';
			case 'torrent_card_screen.files_info_tab.file_card.progress_label': return 'Прогресс';
			case 'torrent_card_screen.files_info_tab.file_card.seeding_label': return 'Сидируется';
			case 'torrent_card_screen.files_info_tab.file_card.available_label': return 'Доступно';
			case 'torrent_card_screen.files_info_tab.file_card.yes': return 'Да';
			case 'torrent_card_screen.files_info_tab.file_card.no': return 'Нет';
			case 'torrent_card_screen.files_info_tab.file_settings_dialog.title': return 'Настройки файла';
			case 'torrent_card_screen.files_info_tab.file_settings_dialog.name_label': return 'Название файла';
			case 'torrent_card_screen.files_info_tab.file_settings_dialog.priority_label': return 'Приоритет';
			case 'torrent_card_screen.files_info_tab.file_settings_dialog.unknown': return 'Неизвестно';
			case 'torrent_card_screen.files_info_tab.file_settings_dialog.cancel_button': return 'Отмена';
			case 'torrent_card_screen.files_info_tab.file_settings_dialog.confirm_button': return 'Подтвердить';
			case 'add_torrent_screen.title': return 'Добавить торрент';
			case 'add_torrent_screen.add_all_button': return 'Добавить все';
			case 'add_torrent_screen.file_picker_section.add_files_button_label': return 'Добавить файлы';
			case 'add_torrent_screen.torrent_card.pause_at_start_label': return 'Пауза при старте';
			case 'add_torrent_screen.torrent_card.skip_checking_label': return 'Пропустить проверку';
			case 'models.torrent_state.error': return 'Ошибка';
			case 'models.torrent_state.missing_files': return 'Отсутствуют файлы';
			case 'models.torrent_state.uploading': return 'Раздача';
			case 'models.torrent_state.paused_up': return 'Раздача приостановлена';
			case 'models.torrent_state.queued_up': return 'В очереди на раздачу';
			case 'models.torrent_state.stalled_up': return 'Раздача остановлена';
			case 'models.torrent_state.stopped_up': return 'Раздача остановлена';
			case 'models.torrent_state.checking_up': return 'Проверка раздачи';
			case 'models.torrent_state.forced_up': return 'Принудительная раздача';
			case 'models.torrent_state.allocating': return 'Выделение места';
			case 'models.torrent_state.downloading': return 'Загрузка';
			case 'models.torrent_state.meta_dl': return 'Загрузка метаданных';
			case 'models.torrent_state.stopped_dl': return 'Загрузка приостановлена';
			case 'models.torrent_state.queued_dl': return 'В очереди на загрузку';
			case 'models.torrent_state.stalled_dl': return 'Загрузка остановлена';
			case 'models.torrent_state.checking_dl': return 'Проверка загрузки';
			case 'models.torrent_state.forced_dl': return 'Принудительная загрузка';
			case 'models.torrent_state.checking_resume_data': return 'Проверка данных';
			case 'models.torrent_state.moving': return 'Перемещение файлов';
			case 'models.torrent_state.unknown': return 'Неизвестный статус';
			case 'models.file_priority.dont_download': return 'Не загружать';
			case 'models.file_priority.normal': return 'Нормальный';
			case 'models.file_priority.high': return 'Высокий';
			case 'models.file_priority.maximal': return 'Максимальный';
			default: return null;
		}
	}
}

