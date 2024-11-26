// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) => Todo(
      name: json['name'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      status: $enumDecode(_$StatusEnumMap, json['status']),
    );

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'status': _$StatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$StatusEnumMap = {
  Status.todo: 'todo',
  Status.inprogress: 'inprogress',
  Status.done: 'done',
};
