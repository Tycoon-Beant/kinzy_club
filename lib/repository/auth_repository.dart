import 'package:kinzy_club/repository/local_storage_repository.dart';

import '../screens/auth/models/user.dart';

class AuthRepository {
  final LocalStorageRepository _localStorageRepository;

  AuthRepository(this._localStorageRepository);

  User? currentUser() {
    return _localStorageRepository.getUserDetails();
  }

  Future<User?> login({required String email, required String password}) async {
    try {
      final credential = _localStorageRepository.getUserDetails();
      await Future.delayed(const Duration(seconds: 1));
      if (credential?.email == email && credential?.password == password) {
        return credential;
      } else {
        throw 'User details not found! Please register first!';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> register(Map<String, dynamic> data) async {
    try {
      await _localStorageRepository.saveUserDetails(User.fromJson(data));
      await Future.delayed(const Duration(seconds: 1));
      return 'User registered successfully.';
    } catch (e) {
      rethrow;
    }
  }
}
