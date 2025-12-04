import '../../../../../common/dependencies/dio/dio.dart';
import '../model/home_default_model.dart';

abstract class HomeRepository {
  Future<List<UniversityModel>> getUniversities();
  Future<List<FacultyModel>> getFaculties(String universityId);
  Future<List<CourseModel>> getCourses(String facultyId);
  Future<List<DirectionModel>> getDirections(String courseId);
}

final class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl({required Dio dio}) : _dio = dio;
  final Dio _dio;

  @override
  Future<List<UniversityModel>> getUniversities() async {
    await _dio.get<List<UniversityModel>>('Urls.universities');
    final defData = <UniversityModel>[
      const UniversityModel(id: 'u1', name: 'Alfraganus'),
      const UniversityModel(id: 'u2', name: 'Toshkent davlat Iqtisodiyot University'),
      const UniversityModel(id: 'u3', name: 'Toshkent davlat Yuridik University'),
      const UniversityModel(id: 'u4', name: 'WUIT'),
    ];
    return defData;
  }

  @override
  Future<List<FacultyModel>> getFaculties(String universityId) async {
    await _dio.get<List<FacultyModel>>('Urls.faculties');

    final defData = <FacultyModel>[
      const FacultyModel(id: 'f_all', name: 'Barcha Fakultetlar'),
      const FacultyModel(id: 'f1', name: 'Faculty of Economics'),
      const FacultyModel(id: 'f2', name: 'Faculty of Medicine'),
      const FacultyModel(id: 'f3', name: 'Faculty of Social Sciences'),
      const FacultyModel(id: 'f4', name: 'Faculty of Philology'),
    ];
    return defData;
  }

  @override
  Future<List<CourseModel>> getCourses(String facultyId) async {
    await _dio.get<List<CourseModel>>('Urls.courses');

    final defData = <CourseModel>[
      const CourseModel(id: 'c_all', name: 'Barcha kurslar'),
      const CourseModel(id: 'c1', name: '1-kurs'),
      const CourseModel(id: 'c2', name: '2-kurs'),
      const CourseModel(id: 'c3', name: '3-kurs'),
      const CourseModel(id: 'c4', name: '4-kurs'),
    ];
    return defData;
  }

  @override
  Future<List<DirectionModel>> getDirections(String courseId) async {
    await _dio.get<List<DirectionModel>>('Urls.directions');

    final defData = <DirectionModel>[
      DirectionModel(id: 'd_all', name: 'Barcha yo’nalishlar'),
      DirectionModel(id: 'd1', name: 'Economy'),
      DirectionModel(id: 'd2', name: 'World economy and international econ...'),
    ];
    return defData;
  }
}
