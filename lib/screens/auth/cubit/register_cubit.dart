
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinzy_club/screens/auth/cubit/login_cubit.dart';

import '../../../repository/auth_repository.dart';

class RegisterCubit extends Cubit<SignupState> {
  final AuthRepository _authRepository;
  final Map<String, dynamic> _formData = {};
  RegisterCubit(this._authRepository) : super(SignupInitial());

  Future<void> register() async {
    try {
      emit(SignupLoading());
      final result = await _authRepository.register(_formData);
      emit(SignupSuccess(response: result));
    } catch (e) {
      emit(SignupError(message: e.toString()));
    }
  }

  void updateForm(String key, dynamic value) async {
    _formData[key] = value;
  }
}
