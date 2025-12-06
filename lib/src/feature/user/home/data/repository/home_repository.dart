import '../model/home_default_model.dart';

abstract class HomeRepository {
  Future<List<UniversityModel>> getUniversities();
  Future<List<FacultyModel>> getFaculties(String universityId);
  Future<List<CourseModel>> getCourses(String facultyId);
  Future<List<DirectionModel>> getDirections(String courseId);
}