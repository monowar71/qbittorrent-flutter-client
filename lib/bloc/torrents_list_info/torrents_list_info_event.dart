part of 'torrents_list_info_bloc.dart';

abstract class TorrentsListInfoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchTorrentsEvent extends TorrentsListInfoEvent {}