import 'package:supabase_service/supabase_service.dart';

import '../model/user_model.dart';
import 'auth_repository.dart';

class SupabaseRepository implements AuthRepository {
  SupabaseRepository({required SupabaseService service}) : _service = service;

  final SupabaseService _service;

  @override
  Future<void> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }

  @override
  Future<UserModel> login({required String telegramID}) async =>
      UserModel.fromJson(await _service.login(telegramID: telegramID));

  @override
  Future<UserModel> signUp({
    required String telegramID,
    required String name,
    required String telegramUsername,
  }) async =>
      UserModel.fromJson(await _service.signUp(telegramID: telegramID, name: name, telegramUsername: telegramUsername));
}
