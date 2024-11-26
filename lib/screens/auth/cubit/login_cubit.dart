import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:kinzy_club/repository/auth_repository.dart';

import '../models/user.dart';

part 'auth_state.dart';

class LoginCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  final Map<String, dynamic> _formData = {};
  LoginCubit(this._authRepository) : super(AuthInitial()) {
    Future.delayed(const Duration(seconds: 0), () {
      final user = _authRepository.currentUser();
      if (user != null) {
        emit(AuthSuccess(user: user));
      }
    });
  }

  Future<void> login() async {
    try {
      emit(AuthLoading());
      final result = await _authRepository.login(
        email: _formData["email"]!,
        password: _formData["password"],
      );
      emit(AuthSuccess(user: result));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  void updateForm(String key, dynamic value) async {
    _formData[key] = value;
  }
}
