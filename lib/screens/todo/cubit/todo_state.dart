import 'package:json_annotation/json_annotation.dart';

import '../models/todo.dart';

part "todo_state.g.dart";

@JsonSerializable()
class TodoState {
  final Status status;
  final List<Todo> todoList;

  TodoState({this.status = Status.todo, required this.todoList});

  TodoState copyWith({Status? newStatus, List<Todo>? newTodoList}) {
    return TodoState(
      status: newStatus?? status,
      todoList: newTodoList?? todoList,
    );
  }

  factory TodoState.fromJson(Map<String, dynamic> json) => _$TodoStateFromJson(json);
  Map<String, dynamic> toJson() => _$TodoStateToJson(this);
}