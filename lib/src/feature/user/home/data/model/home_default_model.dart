class DirectionModel {
  const DirectionModel({required this.id, required this.name});
  final String id;
  final String name;
}

class CourseModel {
  const CourseModel({required this.id, required this.name, this.directions = const []});
  final String id;
  final String name;
  final List<DirectionModel> directions;
}

class FacultyModel {
  const FacultyModel({required this.id, required this.name, this.courses = const []});
  final String id;
  final String name;
  final List<CourseModel> courses;
}

class UniversityModel {
  const UniversityModel({required this.id, required this.name, this.faculties = const []});
  final String id;
  final String name;
  final List<FacultyModel> faculties;
}
