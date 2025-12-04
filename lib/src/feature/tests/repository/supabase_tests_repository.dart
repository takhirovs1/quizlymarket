import 'package:supabase_service/supabase_service.dart';

import '../model/test_model.dart';
import 'tests_repository.dart';

class SupabaseTestsRepository implements TestsRepository {
  SupabaseTestsRepository({required SupabaseService service}) : _service = service;
  final SupabaseService _service;
  @override
  Future<List<TestModel>> getTests({String? search}) async => (await _service.getTests(search: search)).map(TestModel.fromJson).toList();
}
