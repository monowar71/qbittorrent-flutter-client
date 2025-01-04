import 'package:json_annotation/json_annotation.dart';

part 'torrent_info.g.dart';

@JsonSerializable()
class TorrentInfo {
  @JsonKey(name: 'added_on')
  final int? addedOn;
  @JsonKey(name: 'amount_left')
  final int? amountLeft;
  @JsonKey(name: 'auto_tmm')
  final bool? autoTmm;
  final double? availability;
  final String? category;
  final String? comment;
  final int completed;
  @JsonKey(name: 'completion_on')
  final int? completionOn;
  @JsonKey(name: 'content_path')
  final String? contentPath;
  @JsonKey(name: 'dl_limit')
  final int? dlLimit;
  final int? dlspeed;
  @JsonKey(name: 'download_path')
  final String? downloadPath;
  final int? downloaded;
  @JsonKey(name: 'downloaded_session')
  final int? downloadedSession;
  final int? eta;
  @JsonKey(name: 'f_l_piece_prio')
  final bool? firstLastPiecePrio;
  @JsonKey(name: 'force_start')
  final bool? forceStart;
  @JsonKey(name: 'has_metadata')
  final bool? hasMetadata;
  final String? hash;
  @JsonKey(name: 'inactive_seeding_time_limit')
  final int? inactiveSeedingTimeLimit;
  @JsonKey(name: 'infohash_v1')
  final String? infohashV1;
  @JsonKey(name: 'infohash_v2')
  final String? infohashV2;
  @JsonKey(name: 'last_activity')
  final int? lastActivity;
  @JsonKey(name: 'magnet_uri')
  final String? magnetUri;
  @JsonKey(name: 'max_inactive_seeding_time')
  final int? maxInactiveSeedingTime;
  @JsonKey(name: 'max_ratio')
  final double? maxRatio;
  @JsonKey(name: 'max_seeding_time')
  final int? maxSeedingTime;
  final String? name;
  @JsonKey(name: 'num_complete')
  final int? numComplete;
  @JsonKey(name: 'num_incomplete')
  final int? numIncomplete;
  @JsonKey(name: 'num_leechs')
  final int? numLeechs;
  @JsonKey(name: 'num_seeds')
  final int? numSeeds;
  final double? popularity;
  final int? priority;
  final bool? private;
  final double? progress;
  final double? ratio;
  @JsonKey(name: 'ratio_limit')
  final int? ratioLimit;
  final int? reannounce;
  @JsonKey(name: 'root_path')
  final String? rootPath;
  @JsonKey(name: 'save_path')
  final String? savePath;
  @JsonKey(name: 'seeding_time')
  final int? seedingTime;
  @JsonKey(name: 'seeding_time_limit')
  final int? seedingTimeLimit;
  @JsonKey(name: 'seen_complete')
  final int? seenComplete;
  @JsonKey(name: 'seq_dl')
  final bool? sequentialDownload;
  final int? size;
  final String? state;
  @JsonKey(name: 'super_seeding')
  final bool? superSeeding;
  final String? tags;
  @JsonKey(name: 'time_active')
  final int? timeActive;
  @JsonKey(name: 'total_size')
  final int? totalSize;
  final String? tracker;
  @JsonKey(name: 'trackers_count')
  final int? trackersCount;
  @JsonKey(name: 'up_limit')
  final int? upLimit;
  final int? uploaded;
  @JsonKey(name: 'uploaded_session')
  final int? uploadedSession;
  final int? upspeed;

  TorrentInfo({
    required this.addedOn,
    required this.amountLeft,
    required this.autoTmm,
    required this.availability,
    required this.category,
    required this.comment,
    required this.completed,
    required this.completionOn,
    required this.contentPath,
    required this.dlLimit,
    required this.dlspeed,
    required this.downloadPath,
    required this.downloaded,
    required this.downloadedSession,
    required this.eta,
    required this.firstLastPiecePrio,
    required this.forceStart,
    required this.hasMetadata,
    required this.hash,
    required this.inactiveSeedingTimeLimit,
    required this.infohashV1,
    required this.infohashV2,
    required this.lastActivity,
    required this.magnetUri,
    required this.maxInactiveSeedingTime,
    required this.maxRatio,
    required this.maxSeedingTime,
    required this.name,
    required this.numComplete,
    required this.numIncomplete,
    required this.numLeechs,
    required this.numSeeds,
    required this.popularity,
    required this.priority,
    required this.private,
    required this.progress,
    required this.ratio,
    required this.ratioLimit,
    required this.reannounce,
    required this.rootPath,
    required this.savePath,
    required this.seedingTime,
    required this.seedingTimeLimit,
    required this.seenComplete,
    required this.sequentialDownload,
    required this.size,
    required this.state,
    required this.superSeeding,
    required this.tags,
    required this.timeActive,
    required this.totalSize,
    required this.tracker,
    required this.trackersCount,
    required this.upLimit,
    required this.uploaded,
    required this.uploadedSession,
    required this.upspeed,
  });

  factory TorrentInfo.fromJson(Map<String, dynamic> json) =>
      _$TorrentInfoFromJson(json);

  Map<String, dynamic> toJson() => _$TorrentInfoToJson(this);
}
