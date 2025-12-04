part of 'filter_bloc.dart';

sealed class FilterEvent {}

final class FilterUniversityEvent extends FilterEvent {}

final class FilterFacultyEvent extends FilterEvent {
  FilterFacultyEvent({required this.universityModel});
  final UniversityModel universityModel;
}

final class FilterCourseEvent extends FilterEvent {
  FilterCourseEvent({required this.facultyModel});
  final FacultyModel facultyModel;
}

final class FilterDirectionEvent extends FilterEvent {
  FilterDirectionEvent({required this.courseModel});
  final CourseModel courseModel;
}
