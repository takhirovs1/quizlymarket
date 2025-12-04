import '../../../../../common/enum/user_role_enum.dart';
import '../model/user_list_model.dart';

abstract class ClientRepository {
  Future<List<ClientModel>> getClients({String searchQuery = ''});
  Future<ClientModel> updateClientRole(String userID, UserRole role);
}
