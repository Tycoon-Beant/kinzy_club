// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoState _$TodoStateFromJson(Map<String, dynamic> json) => TodoState(
      status:
          $enumDecodeNullable(_$StatusEnumMap, json['status']) ?? Status.todo,
      todoList: (json['todoList'] as List<dynamic>)
          .map((e) => Todo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TodoStateToJson(TodoState instance) => <String, dynamic>{
      'status': _$StatusEnumMap[instance.status]!,
      'todoList': instance.todoList,
    };

const _$StatusEnumMap = {
  Status.todo: 'todo',
  Status.inprogress: 'inprogress',
  Status.done: 'done',
};
