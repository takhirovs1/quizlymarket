import 'package:supabase_service/supabase_service.dart';

import '../model/home_default_model.dart';
import 'home_repository.dart';

class SupabaseHomeRepository implements HomeRepository {
  SupabaseHomeRepository({required SupabaseService service}) : _service = service;

  final SupabaseService _service;

  @override
  Future<List<CourseModel>> getCourses(String facultyId) {
    throw UnimplementedError();
  }

  @override
  Future<List<DirectionModel>> getDirections(String courseId) {
    throw UnimplementedError();
  }

  @override
  Future<List<FacultyModel>> getFaculties(String universityId) {
    throw UnimplementedError();
  }

  @override
  Future<List<UniversityModel>> getUniversities() async =>
      (await _service.getUniversities()).map(UniversityModel.fromJson).toList();
}
