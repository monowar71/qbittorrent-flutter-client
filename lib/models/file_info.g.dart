// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileInfo _$FileInfoFromJson(Map<String, dynamic> json) => FileInfo(
      index: (json['index'] as num).toInt(),
      name: json['name'] as String,
      size: (json['size'] as num).toInt(),
      progress: (json['progress'] as num).toDouble(),
      priority: FilePriority.fromJson((json['priority'] as num).toInt()),
      isSeed: json['is_seed'] as bool?,
      pieceRange: (json['piece_range'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      availability: (json['availability'] as num).toDouble(),
    );

Map<String, dynamic> _$FileInfoToJson(FileInfo instance) => <String, dynamic>{
      'index': instance.index,
      'name': instance.name,
      'size': instance.size,
      'progress': instance.progress,
      'priority': FilePriority.toJson(instance.priority),
      'is_seed': instance.isSeed,
      'piece_range': instance.pieceRange,
      'availability': instance.availability,
    };
