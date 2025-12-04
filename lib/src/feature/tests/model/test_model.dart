class TestModel {
  const TestModel({
    required this.id,
    required this.title,
    required this.price,
    required this.questionCount,
    required this.subject,
    this.academicYear,
    this.semester,
  });

  factory TestModel.fromJson(Map<String, dynamic> json) => TestModel(
    id: json['id'] as int,
    title: json['title'] as String,
    price: (json['price'] as num).toInt(),
    questionCount: json['question_count'] as int,
    subject: SubjectModel.fromJson(json['subject'] as Map<String, dynamic>),
    academicYear: json['academic_year'] as String?,
    semester: json['semester'] as int?,
  );

  final int id;
  final String title;
  final int price;
  final int questionCount;
  final SubjectModel subject;
  final String? academicYear;
  final int? semester;

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'price': price,
    'question_count': questionCount,
    'subject': subject.toJson(),
    'academic_year': academicYear,
    'semester': semester,
  };
}

class SubjectModel {
  const SubjectModel({required this.id, required this.name, required this.direction});

  factory SubjectModel.fromJson(Map<String, dynamic> json) => SubjectModel(
    id: json['id'] as int,
    name: json['name'] as String,
    direction: DirectionModel.fromJson(json['direction'] as Map<String, dynamic>),
  );
  final int id;
  final String name;
  final DirectionModel direction;

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'direction': direction.toJson()};
}

class CourseModel {
  const CourseModel({required this.id, required this.name, required this.faculty});

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
    id: json['id'] as int,
    name: json['name'] as String,
    faculty: FacultyModel.fromJson(json['faculty'] as Map<String, dynamic>),
  );
  final int id;
  final String name;
  final FacultyModel faculty;

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'faculty': faculty.toJson()};
}

class DirectionModel {
  const DirectionModel({required this.id, required this.name, required this.course});

  factory DirectionModel.fromJson(Map<String, dynamic> json) => DirectionModel(
    id: json['id'] as int,
    name: json['name'] as String,
    course: CourseModel.fromJson(json['course'] as Map<String, dynamic>),
  );
  final int id;
  final String name;
  final CourseModel course;

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'course': course.toJson()};
}

class FacultyModel {
  const FacultyModel({required this.id, required this.name, required this.university});

  factory FacultyModel.fromJson(Map<String, dynamic> json) => FacultyModel(
    id: json['id'] as int,
    name: json['name'] as String,
    university: UniversityModel.fromJson(json['university'] as Map<String, dynamic>),
  );
  final int id;
  final String name;
  final UniversityModel university;

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'university': university.toJson()};
}

class UniversityModel {
  const UniversityModel({required this.id, required this.name});

  factory UniversityModel.fromJson(Map<String, dynamic> json) =>
      UniversityModel(id: json['id'] as int, name: json['name'] as String);
  final int id;
  final String name;

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

extension TestUiExt on TestModel {
  String get directionName => subject.direction.name;

  String get courseText => subject.direction.course.name;

  String get universityName => subject.direction.course.faculty.university.name;

  String get academicYearText => academicYear ?? '';

  String get semesterText => semester?.toString() ?? '';

  String get academicYearSemesterText => '$academicYearText $semesterText-semester';
}
