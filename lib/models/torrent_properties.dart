import 'package:json_annotation/json_annotation.dart';

part 'torrent_properties.g.dart';

@JsonSerializable()
class TorrentProperties {
  final String? savePath;
  final int? creationDate;
  final int? pieceSize;
  final String? comment;
  final int? totalWasted;
  final int? totalUploaded;
  final int? totalUploadedSession;
  final int? totalDownloaded;
  final int? totalDownloadedSession;
  final int? upLimit;
  final int? dlLimit;
  final int? timeElapsed;
  final int? seedingTime;
  final int? nbConnections;
  final int? nbConnectionsLimit;
  final double? shareRatio;
  final int? additionDate;
  final int? completionDate;
  final String? createdBy;
  final int? dlSpeedAvg;
  final int? dlSpeed;
  final int? eta;
  final int? lastSeen;
  final int? peers;
  final int? peersTotal;
  final int? piecesHave;
  final int? piecesNum;
  final int? reannounce;
  final int? seeds;
  final int? seedsTotal;
  final int? totalSize;
  final int? upSpeedAvg;
  final int? upSpeed;
  final bool? isPrivate;

  TorrentProperties({
    this.savePath,
    this.creationDate,
    this.pieceSize,
    this.comment,
    this.totalWasted,
    this.totalUploaded,
    this.totalUploadedSession,
    this.totalDownloaded,
    this.totalDownloadedSession,
    this.upLimit,
    this.dlLimit,
    this.timeElapsed,
    this.seedingTime,
    this.nbConnections,
    this.nbConnectionsLimit,
    this.shareRatio,
    this.additionDate,
    this.completionDate,
    this.createdBy,
    this.dlSpeedAvg,
    this.dlSpeed,
    this.eta,
    this.lastSeen,
    this.peers,
    this.peersTotal,
    this.piecesHave,
    this.piecesNum,
    this.reannounce,
    this.seeds,
    this.seedsTotal,
    this.totalSize,
    this.upSpeedAvg,
    this.upSpeed,
    this.isPrivate,
  });

  factory TorrentProperties.fromJson(Map<String, dynamic> json) => _$TorrentPropertiesFromJson(json);
  Map<String, dynamic> toJson() => _$TorrentPropertiesToJson(this);
}
