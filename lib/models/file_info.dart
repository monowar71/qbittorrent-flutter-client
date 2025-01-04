import 'package:json_annotation/json_annotation.dart';

part 'file_info.g.dart';

@JsonSerializable()
class FileInfo {

  final int index;
  final String name;
  final int size;
  final double progress;
  final int priority;
  @JsonKey(name: 'is_seed')
  final bool? isSeed;
  @JsonKey(name: 'piece_range')
  final List<int> pieceRange;
  final double availability;

  FileInfo({
    required this.index,
    required this.name,
    required this.size,
    required this.progress,
    required this.priority,
    required this.isSeed,
    required this.pieceRange,
    required this.availability,
  });

  factory FileInfo.fromJson(Map<String, dynamic> json) =>
      _$FileInfoFromJson(json);
  Map<String, dynamic> toJson() => _$FileInfoToJson(this);
}