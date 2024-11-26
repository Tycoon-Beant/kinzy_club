import 'dart:convert';

import 'package:kinzy_club/screens/todo/cubit/todo_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/auth/models/user.dart';
import '../screens/todo/models/todo.dart';

class LocalStorageRepository {
  final SharedPreferences _preferences;
  final String _user = "user";

  LocalStorageRepository(this._preferences);

  Future<void> saveUserDetails(User user) async {
    await _preferences.setString(_user, jsonEncode(user.toJson()));
  }

  User? getUserDetails() {
    final String? json = _preferences.getString(_user);
    if (json != null) return User.fromJson(jsonDecode(json));
    return null;
  }

  Future<void> saveTodos(List<TodoState> todos) async {
    await _preferences.setStringList("todo", todos.map((e) => jsonEncode(e.toJson())).toList());
  }

  List<TodoState> getTodos() {
    final List<String>? json = _preferences.getStringList("todo");
    if (json != null) {
      return json.map((e) => TodoState.fromJson(jsonDecode(e))).toList();
    }
    return [];
  }

  Future<void> clearSession() async {
    _preferences.remove(_user);
  }
}
