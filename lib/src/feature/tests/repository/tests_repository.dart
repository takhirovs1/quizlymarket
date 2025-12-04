import '../model/test_model.dart';

abstract class TestsRepository {
  Future<List<TestModel>> getTests({String? search});
}
