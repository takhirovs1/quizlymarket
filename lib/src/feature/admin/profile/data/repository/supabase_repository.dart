import 'package:supabase_service/supabase_service.dart';

import '../../../../../common/enum/user_role_enum.dart';
import '../model/user_list_model.dart';
import 'client_repository.dart';

class SupabaseClientRepository implements ClientRepository {
  SupabaseClientRepository({required SupabaseService service}) : _service = service;

  final SupabaseService _service;

  @override
  Future<List<ClientModel>> getClients({String searchQuery = ''}) async {
    final query = <String, Object?>{};
    final trimmedQuery = searchQuery.trim();
    if (trimmedQuery.isNotEmpty) {
      query['full_name'] = trimmedQuery;
    }

    final response = await _service.getAllUsers(query);
    return response.map(ClientModel.fromJson).toList();
  }

  @override
  Future<ClientModel> updateClientRole(String userID, UserRole role) {
    throw UnimplementedError();
  }
}
