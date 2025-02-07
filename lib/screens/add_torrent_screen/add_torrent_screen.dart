import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qbittorrent_client/bloc/add_torrent/add_torrent_bloc.dart';
import 'package:qbittorrent_client/i18n/strings.g.dart';
import 'package:qbittorrent_client/screens/add_torrent_screen/widgets/file_picker_section.dart';
import 'package:qbittorrent_client/screens/add_torrent_screen/widgets/torrent_card.dart';

class AddTorrentScreen extends StatelessWidget {
  const AddTorrentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.add_torrent_screen.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AddTorrentBloc, AddTorrentState>(
          listener: (context, state) {
            if (state is AddTorrentError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
            if (state is AddTorrentSuccess) {
              Navigator.of(context).pop();
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const FilePickerSection(),
                if (state is FilesSelectedState)
                  Expanded(
                    child: ListView(
                      children: state.settingsList
                          .map((settings) => TorrentCard(settings: settings))
                          .toList(),
                    ),
                  ),
                if (state is FilesSelectedState && state.settingsList.isNotEmpty)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      context.read<AddTorrentBloc>().add(UploadTorrentEvent(settingsList: state.settingsList));
                    },
                    child: Text(t.add_torrent_screen.add_all_button),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
