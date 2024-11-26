import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:kinzy_club/repository/local_storage_repository.dart';
import 'package:kinzy_club/screens/todo/cubit/todo_state.dart';

import '../models/todo.dart';

class TodolistCubit extends Cubit<List<TodoState>> {
  final LocalStorageRepository _localStorageRepository;
  TodolistCubit(this._localStorageRepository) : super([]) {
    final todoState = _localStorageRepository.getTodos();
    if (todoState.isNotEmpty) {
      emit(todoState);
    } else {
      emit(Status.values.map((e) => TodoState(todoList: [], status: e)).toList());
    }
  }

  void replaceTodo(Todo todo, Status status) {
    final newState = [
      for (TodoState t in state)
        if (t.status == todo.status)
          t.copyWith(newTodoList: t.todoList.where((e) => e.name != todo.name).toList())
        else if (t.status == status)
          t.copyWith(newTodoList: [...t.todoList, todo.copyWith(status: status)])
        else
          t
    ];
    _localStorageRepository.saveTodos(newState);
    emit(newState);
  }

  void updateTodo(Todo todo, int index) {
    final newState = [
      for (TodoState t in state)
        if (t.status == todo.status)
          t.copyWith(newTodoList: t.todoList.mapIndexed((i, e) => i == index ? todo : e).toList())
        else
          t
    ];
    _localStorageRepository.saveTodos(newState);
    emit(newState);
  }

  void addTodo(Todo todo) {
    final newState = [
      for (TodoState t in state)
        if (t.status == todo.status) t.copyWith(newTodoList: [...t.todoList, todo]) else t
    ];
    _localStorageRepository.saveTodos(newState);
    emit(newState);
  }

  void removeTodo(Todo todo) {
    final newState = [
      for (TodoState t in state)
        if (t.status == todo.status)
          t.copyWith(newTodoList: t.todoList.where((e) => e.name != todo.name).toList())
        else
          t
    ];
    _localStorageRepository.saveTodos(newState);
    emit(newState);
  }
}
