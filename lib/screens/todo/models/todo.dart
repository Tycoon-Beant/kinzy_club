import 'package:json_annotation/json_annotation.dart';

part "todo.g.dart";

@JsonSerializable()
class Todo {
  final String name;
  final String description;
  final Status status;
  final DateTime createdAt;

  Todo({
    required this.name,
    required this.description,
    required this.createdAt,
    required this.status,
  });

  factory Todo.empty() =>
      Todo(name: "", description: "", createdAt: DateTime.now(), status: Status.todo);

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  Todo copyWith({String? name, String? description, DateTime? createdAt, Status? status}) {
    return Todo(
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() => _$TodoToJson(this);
}

enum Status { todo, inprogress, done }
