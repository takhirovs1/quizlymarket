part of 'filter_bloc.dart';

class FilterState extends Equatable {
  const FilterState({
    this.filterStatus = Status.initial,
    this.course = const [],
    this.direction = const [],
    this.faculty = const [],
    this.university = const [],
    this.error = '',
  });

  factory FilterState.initial() => const FilterState(
    filterStatus: Status.initial,
    university: [],
    faculty: [],
    course: [],
    direction: [],
    error: '',
  );
  final Status filterStatus;
  final List<UniversityModel> university;
  final List<FacultyModel> faculty;
  final List<CourseModel> course;
  final List<DirectionModel> direction;

  final String error;
  FilterState copyWith({
    Status? filterStatus,
    List<UniversityModel>? university,
    List<FacultyModel>? faculty,
    List<CourseModel>? course,
    List<DirectionModel>? direction,
    String? error,
  }) => FilterState(
    filterStatus: filterStatus ?? this.filterStatus,
    university: university ?? this.university,
    faculty: faculty ?? this.faculty,
    course: course ?? this.course,
    direction: direction ?? this.direction,
    error: error ?? this.error,
  );
  @override
  List<Object?> get props => [filterStatus, university, faculty, course, direction, error];
}
