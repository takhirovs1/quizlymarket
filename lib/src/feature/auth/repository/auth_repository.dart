import '../model/user_model.dart';

abstract class AuthRepository {
  Future<UserModel> login({required String telegramID});
  Future<UserModel> signUp({required String telegramID, required String name});
  Future<void> logOut();
}
