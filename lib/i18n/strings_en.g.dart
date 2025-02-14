///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	// Translations
	late final TranslationsAuthScreenEn auth_screen = TranslationsAuthScreenEn._(_root);
	late final TranslationsTorrentListScreenEn torrent_list_screen = TranslationsTorrentListScreenEn._(_root);
	late final TranslationsTorrentCardScreenEn torrent_card_screen = TranslationsTorrentCardScreenEn._(_root);
	late final TranslationsAddTorrentScreenEn add_torrent_screen = TranslationsAddTorrentScreenEn._(_root);
	late final TranslationsModelsEn models = TranslationsModelsEn._(_root);
}

// Path: auth_screen
class TranslationsAuthScreenEn {
	TranslationsAuthScreenEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Qbittorrent Client';
	String get server_ip_or_dns => 'Server IP or DDNS';
	String get port_number => 'Port Number';
	String get https => 'HTTPS';
	String get username => 'Username';
	String get password => 'Password';
	String get save_credentials => 'Save?';
	String get enter_automatically => 'Enter automatically?';
	String get enter => 'Enter';
}

// Path: torrent_list_screen
class TranslationsTorrentListScreenEn {
	TranslationsTorrentListScreenEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Torrent List';
	String get loading_torrents => 'Loading torrents...';
	String get torrents_error => 'Error loading torrents {error}';
	String get no_active_torrents => 'No active torrents';
	late final TranslationsTorrentListScreenSortByEn sort_by = TranslationsTorrentListScreenSortByEn._(_root);
}

// Path: torrent_card_screen
class TranslationsTorrentCardScreenEn {
	TranslationsTorrentCardScreenEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Torrent Details';
	String get base_info_tab_label => 'Basic Info';
	String get files_info_tab_label => 'Files';
	late final TranslationsTorrentCardScreenBaseInfoTabEn base_info_tab = TranslationsTorrentCardScreenBaseInfoTabEn._(_root);
	late final TranslationsTorrentCardScreenFilesInfoTabEn files_info_tab = TranslationsTorrentCardScreenFilesInfoTabEn._(_root);
}

// Path: add_torrent_screen
class TranslationsAddTorrentScreenEn {
	TranslationsAddTorrentScreenEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Add Torrent';
	String get add_all_button => 'Add All';
	late final TranslationsAddTorrentScreenFilePickerSectionEn file_picker_section = TranslationsAddTorrentScreenFilePickerSectionEn._(_root);
	late final TranslationsAddTorrentScreenTorrentCardEn torrent_card = TranslationsAddTorrentScreenTorrentCardEn._(_root);
}

// Path: models
class TranslationsModelsEn {
	TranslationsModelsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsModelsTorrentStateEn torrent_state = TranslationsModelsTorrentStateEn._(_root);
	late final TranslationsModelsFilePriorityEn file_priority = TranslationsModelsFilePriorityEn._(_root);
}

// Path: torrent_list_screen.sort_by
class TranslationsTorrentListScreenSortByEn {
	TranslationsTorrentListScreenSortByEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get name => 'By Name';
	String get size => 'By Size';
	String get date_added => 'By Date Added';
}

// Path: torrent_card_screen.base_info_tab
class TranslationsTorrentCardScreenBaseInfoTabEn {
	TranslationsTorrentCardScreenBaseInfoTabEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get main_info_label => 'Main Info';
	String get hash_label => 'Hash';
	String get status_label => 'Status';
	String get name_label => 'Name';
	String get tags_label => 'Tags';
	String get category_label => 'Category';
	String get magnet_uri_label => 'Magnet URI';
	String get save_path_label => 'Save Path';
	String get seeds_peers_section_title => 'Seeds/Peers';
	String get speed_section_title => 'Speed';
	String get actions_section_title => 'Actions';
	late final TranslationsTorrentCardScreenBaseInfoTabTorrentActionsButtonsEn torrent_actions_buttons = TranslationsTorrentCardScreenBaseInfoTabTorrentActionsButtonsEn._(_root);
	late final TranslationsTorrentCardScreenBaseInfoTabFileSizeInfoEn file_size_info = TranslationsTorrentCardScreenBaseInfoTabFileSizeInfoEn._(_root);
	late final TranslationsTorrentCardScreenBaseInfoTabSeedPeersInfoEn seed_peers_info = TranslationsTorrentCardScreenBaseInfoTabSeedPeersInfoEn._(_root);
}

// Path: torrent_card_screen.files_info_tab
class TranslationsTorrentCardScreenFilesInfoTabEn {
	TranslationsTorrentCardScreenFilesInfoTabEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsTorrentCardScreenFilesInfoTabFileCardEn file_card = TranslationsTorrentCardScreenFilesInfoTabFileCardEn._(_root);
	late final TranslationsTorrentCardScreenFilesInfoTabFileSettingsDialogEn file_settings_dialog = TranslationsTorrentCardScreenFilesInfoTabFileSettingsDialogEn._(_root);
}

// Path: add_torrent_screen.file_picker_section
class TranslationsAddTorrentScreenFilePickerSectionEn {
	TranslationsAddTorrentScreenFilePickerSectionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get add_files_button_label => 'Add Files';
}

// Path: add_torrent_screen.torrent_card
class TranslationsAddTorrentScreenTorrentCardEn {
	TranslationsAddTorrentScreenTorrentCardEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get pause_at_start_label => 'Pause at Start';
	String get skip_checking_label => 'Skip Check';
}

// Path: models.torrent_state
class TranslationsModelsTorrentStateEn {
	TranslationsModelsTorrentStateEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get error => 'Error';
	String get missing_files => 'Missing Files';
	String get uploading => 'Uploading';
	String get paused_up => 'Upload Paused';
	String get queued_up => 'Queued for Upload';
	String get stalled_up => 'Upload Stalled';
	String get stopped_up => 'Upload Stopped';
	String get checking_up => 'Checking Upload';
	String get forced_up => 'Forced Upload';
	String get allocating => 'Allocating Space';
	String get downloading => 'Downloading';
	String get meta_dl => 'Downloading Metadata';
	String get stopped_dl => 'Download Paused';
	String get queued_dl => 'Queued for Download';
	String get stalled_dl => 'Download Stalled';
	String get checking_dl => 'Checking Download';
	String get forced_dl => 'Forced Download';
	String get checking_resume_data => 'Checking Data';
	String get moving => 'Moving Files';
	String get unknown => 'Unknown Status';
}

// Path: models.file_priority
class TranslationsModelsFilePriorityEn {
	TranslationsModelsFilePriorityEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get dont_download => 'Don\'t Download';
	String get normal => 'Normal';
	String get high => 'High';
	String get maximal => 'Maximal';
}

// Path: torrent_card_screen.base_info_tab.torrent_actions_buttons
class TranslationsTorrentCardScreenBaseInfoTabTorrentActionsButtonsEn {
	TranslationsTorrentCardScreenBaseInfoTabTorrentActionsButtonsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get resume_button => 'Resume';
	String get pause_button => 'Pause';
	String get delete_button => 'Delete';
	String get delete_confirmation_title => 'Delete Torrent';
	String get delete_confirmation_message => 'How do you want to delete?';
	String get delete_only_torrent => 'Only Torrent';
	String get delete_torrent_and_files => 'Torrent and Files';
	String get cancel_button => 'Cancel';
}

// Path: torrent_card_screen.base_info_tab.file_size_info
class TranslationsTorrentCardScreenBaseInfoTabFileSizeInfoEn {
	TranslationsTorrentCardScreenBaseInfoTabFileSizeInfoEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get total_size_label => 'Total Size';
	String get ratio_label => 'Ratio';
	String get completed_size_label => 'Completed Size';
	String get remaining_size_label => 'Remaining Size';
}

// Path: torrent_card_screen.base_info_tab.seed_peers_info
class TranslationsTorrentCardScreenBaseInfoTabSeedPeersInfoEn {
	TranslationsTorrentCardScreenBaseInfoTabSeedPeersInfoEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get seeds_label => 'Seeds:';
	String get peers_label => 'Peers:';
}

// Path: torrent_card_screen.files_info_tab.file_card
class TranslationsTorrentCardScreenFilesInfoTabFileCardEn {
	TranslationsTorrentCardScreenFilesInfoTabFileCardEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get size_label => 'Size';
	String get priority_label => 'Priority';
	String get progress_label => 'Progress';
	String get seeding_label => 'Seeding';
	String get available_label => 'Available';
	String get yes => 'Yes';
	String get no => 'No';
}

// Path: torrent_card_screen.files_info_tab.file_settings_dialog
class TranslationsTorrentCardScreenFilesInfoTabFileSettingsDialogEn {
	TranslationsTorrentCardScreenFilesInfoTabFileSettingsDialogEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'File Settings';
	String get name_label => 'File Name';
	String get priority_label => 'Priority';
	String get unknown => 'Unknown';
	String get cancel_button => 'Cancel';
	String get confirm_button => 'Confirm';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'auth_screen.title': return 'Qbittorrent Client';
			case 'auth_screen.server_ip_or_dns': return 'Server IP or DDNS';
			case 'auth_screen.port_number': return 'Port Number';
			case 'auth_screen.https': return 'HTTPS';
			case 'auth_screen.username': return 'Username';
			case 'auth_screen.password': return 'Password';
			case 'auth_screen.save_credentials': return 'Save?';
			case 'auth_screen.enter_automatically': return 'Enter automatically?';
			case 'auth_screen.enter': return 'Enter';
			case 'torrent_list_screen.title': return 'Torrent List';
			case 'torrent_list_screen.loading_torrents': return 'Loading torrents...';
			case 'torrent_list_screen.torrents_error': return 'Error loading torrents {error}';
			case 'torrent_list_screen.no_active_torrents': return 'No active torrents';
			case 'torrent_list_screen.sort_by.name': return 'By Name';
			case 'torrent_list_screen.sort_by.size': return 'By Size';
			case 'torrent_list_screen.sort_by.date_added': return 'By Date Added';
			case 'torrent_card_screen.title': return 'Torrent Details';
			case 'torrent_card_screen.base_info_tab_label': return 'Basic Info';
			case 'torrent_card_screen.files_info_tab_label': return 'Files';
			case 'torrent_card_screen.base_info_tab.main_info_label': return 'Main Info';
			case 'torrent_card_screen.base_info_tab.hash_label': return 'Hash';
			case 'torrent_card_screen.base_info_tab.status_label': return 'Status';
			case 'torrent_card_screen.base_info_tab.name_label': return 'Name';
			case 'torrent_card_screen.base_info_tab.tags_label': return 'Tags';
			case 'torrent_card_screen.base_info_tab.category_label': return 'Category';
			case 'torrent_card_screen.base_info_tab.magnet_uri_label': return 'Magnet URI';
			case 'torrent_card_screen.base_info_tab.save_path_label': return 'Save Path';
			case 'torrent_card_screen.base_info_tab.seeds_peers_section_title': return 'Seeds/Peers';
			case 'torrent_card_screen.base_info_tab.speed_section_title': return 'Speed';
			case 'torrent_card_screen.base_info_tab.actions_section_title': return 'Actions';
			case 'torrent_card_screen.base_info_tab.torrent_actions_buttons.resume_button': return 'Resume';
			case 'torrent_card_screen.base_info_tab.torrent_actions_buttons.pause_button': return 'Pause';
			case 'torrent_card_screen.base_info_tab.torrent_actions_buttons.delete_button': return 'Delete';
			case 'torrent_card_screen.base_info_tab.torrent_actions_buttons.delete_confirmation_title': return 'Delete Torrent';
			case 'torrent_card_screen.base_info_tab.torrent_actions_buttons.delete_confirmation_message': return 'How do you want to delete?';
			case 'torrent_card_screen.base_info_tab.torrent_actions_buttons.delete_only_torrent': return 'Only Torrent';
			case 'torrent_card_screen.base_info_tab.torrent_actions_buttons.delete_torrent_and_files': return 'Torrent and Files';
			case 'torrent_card_screen.base_info_tab.torrent_actions_buttons.cancel_button': return 'Cancel';
			case 'torrent_card_screen.base_info_tab.file_size_info.total_size_label': return 'Total Size';
			case 'torrent_card_screen.base_info_tab.file_size_info.ratio_label': return 'Ratio';
			case 'torrent_card_screen.base_info_tab.file_size_info.completed_size_label': return 'Completed Size';
			case 'torrent_card_screen.base_info_tab.file_size_info.remaining_size_label': return 'Remaining Size';
			case 'torrent_card_screen.base_info_tab.seed_peers_info.seeds_label': return 'Seeds:';
			case 'torrent_card_screen.base_info_tab.seed_peers_info.peers_label': return 'Peers:';
			case 'torrent_card_screen.files_info_tab.file_card.size_label': return 'Size';
			case 'torrent_card_screen.files_info_tab.file_card.priority_label': return 'Priority';
			case 'torrent_card_screen.files_info_tab.file_card.progress_label': return 'Progress';
			case 'torrent_card_screen.files_info_tab.file_card.seeding_label': return 'Seeding';
			case 'torrent_card_screen.files_info_tab.file_card.available_label': return 'Available';
			case 'torrent_card_screen.files_info_tab.file_card.yes': return 'Yes';
			case 'torrent_card_screen.files_info_tab.file_card.no': return 'No';
			case 'torrent_card_screen.files_info_tab.file_settings_dialog.title': return 'File Settings';
			case 'torrent_card_screen.files_info_tab.file_settings_dialog.name_label': return 'File Name';
			case 'torrent_card_screen.files_info_tab.file_settings_dialog.priority_label': return 'Priority';
			case 'torrent_card_screen.files_info_tab.file_settings_dialog.unknown': return 'Unknown';
			case 'torrent_card_screen.files_info_tab.file_settings_dialog.cancel_button': return 'Cancel';
			case 'torrent_card_screen.files_info_tab.file_settings_dialog.confirm_button': return 'Confirm';
			case 'add_torrent_screen.title': return 'Add Torrent';
			case 'add_torrent_screen.add_all_button': return 'Add All';
			case 'add_torrent_screen.file_picker_section.add_files_button_label': return 'Add Files';
			case 'add_torrent_screen.torrent_card.pause_at_start_label': return 'Pause at Start';
			case 'add_torrent_screen.torrent_card.skip_checking_label': return 'Skip Check';
			case 'models.torrent_state.error': return 'Error';
			case 'models.torrent_state.missing_files': return 'Missing Files';
			case 'models.torrent_state.uploading': return 'Uploading';
			case 'models.torrent_state.paused_up': return 'Upload Paused';
			case 'models.torrent_state.queued_up': return 'Queued for Upload';
			case 'models.torrent_state.stalled_up': return 'Upload Stalled';
			case 'models.torrent_state.stopped_up': return 'Upload Stopped';
			case 'models.torrent_state.checking_up': return 'Checking Upload';
			case 'models.torrent_state.forced_up': return 'Forced Upload';
			case 'models.torrent_state.allocating': return 'Allocating Space';
			case 'models.torrent_state.downloading': return 'Downloading';
			case 'models.torrent_state.meta_dl': return 'Downloading Metadata';
			case 'models.torrent_state.stopped_dl': return 'Download Paused';
			case 'models.torrent_state.queued_dl': return 'Queued for Download';
			case 'models.torrent_state.stalled_dl': return 'Download Stalled';
			case 'models.torrent_state.checking_dl': return 'Checking Download';
			case 'models.torrent_state.forced_dl': return 'Forced Download';
			case 'models.torrent_state.checking_resume_data': return 'Checking Data';
			case 'models.torrent_state.moving': return 'Moving Files';
			case 'models.torrent_state.unknown': return 'Unknown Status';
			case 'models.file_priority.dont_download': return 'Don\'t Download';
			case 'models.file_priority.normal': return 'Normal';
			case 'models.file_priority.high': return 'High';
			case 'models.file_priority.maximal': return 'Maximal';
			default: return null;
		}
	}
}

