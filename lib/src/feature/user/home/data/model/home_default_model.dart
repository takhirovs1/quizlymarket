class DirectionModel {
  DirectionModel({required this.id, required this.name});
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
  const UniversityModel({required this.id, required this.name, required this.isActive});

  factory UniversityModel.fromJson(Map<String, Object?> json) => UniversityModel(
    id: json['id'] as int? ?? 0,
    name: json['name'] as String? ?? '',
    isActive: json['is_active'] as bool? ?? true,
  );

  final int id;
  final String name;
  final bool isActive;
}
