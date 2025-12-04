class DirectionModel {
  final String id;
  final String name;

  const DirectionModel({required this.id, required this.name});
}

class CourseModel {
  final String id;
  final String name;
  final List<DirectionModel> directions;

  const CourseModel({required this.id, required this.name, this.directions = const []});
}

class FacultyModel {
  final String id;
  final String name;
  final List<CourseModel> courses;

  const FacultyModel({required this.id, required this.name, this.courses = const []});
}

class UniversityModel {
  final String id;
  final String name;
  final List<FacultyModel> faculties;

  const UniversityModel({required this.id, required this.name, this.faculties = const []});
}
