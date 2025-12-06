import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../common/enum/bloc_status_enum.dart';
import '../../../../../../common/enum/filter_step_enum.dart';
import '../../../../../../common/util/error_handler.dart';
import '../../../data/model/home_default_model.dart';
import '../../../data/repository/home_repository.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc({required HomeRepository repository, FilterState? initialState})
    : _repository = repository,
      super(initialState ?? FilterState.initial()) {
    on<FilterEvent>(
      (event, emit) => switch (event) {
        final FilterUniversityEvent e => _onFilterUniversityEvent(e, emit),
        final FilterFacultyEvent e => _onFilterFacultyEvent(e, emit),
        final FilterCourseEvent e => _onFilterCourseEvent(e, emit),
        final FilterDirectionEvent e => _onFilterDirectionEvent(e, emit),
        final FilterBackEvent e => _onFilterBackEvent(e, emit),
      },
    );
  }

  final HomeRepository _repository;

  void _onFilterUniversityEvent(FilterUniversityEvent event, Emitter<FilterState> emit) => handle(() async {
    emit(state.copyWith(filterStatus: Status.loading));
    final data = await _repository.getUniversities();
    emit(state.copyWith(filterStatus: Status.success, university: data, filterStep: FilterStep.university));
  }, onError: (error, stackTrace) => emit(state.copyWith(filterStatus: Status.error, error: error.toString())));

  void _onFilterFacultyEvent(FilterFacultyEvent event, Emitter<FilterState> emit) => handle(() async {
    emit(state.copyWith(filterStatus: Status.loading));
    final data = await _repository.getFaculties(event.universityModel.id);
    emit(state.copyWith(filterStatus: Status.success, faculty: data, filterStep: FilterStep.faculty));
  }, onError: (e, s) => emit(state.copyWith(filterStatus: Status.error, error: e.toString())));

  void _onFilterCourseEvent(FilterCourseEvent event, Emitter<FilterState> emit) => handle(() async {
    emit(state.copyWith(filterStatus: Status.loading));
    final data = await _repository.getCourses(event.facultyModel.id);
    emit(state.copyWith(filterStatus: Status.success, course: data, filterStep: FilterStep.course));
  }, onError: (e, s) => emit(state.copyWith(filterStatus: Status.error, error: e.toString())));

  void _onFilterDirectionEvent(FilterDirectionEvent event, Emitter<FilterState> emit) => handle(() async {
    emit(state.copyWith(filterStatus: Status.loading));
    final data = await _repository.getDirections(event.courseModel.id);
    emit(state.copyWith(filterStatus: Status.success, direction: data, filterStep: FilterStep.direction));
  }, onError: (e, s) => emit(state.copyWith(filterStatus: Status.error, error: e.toString())));

  void _onFilterBackEvent(FilterBackEvent event, Emitter<FilterState> emit) {
    final nextStep = switch (state.filterStep) {
      FilterStep.direction => FilterStep.course,
      FilterStep.course => FilterStep.faculty,
      FilterStep.faculty => FilterStep.university,
      FilterStep.university => FilterStep.university,
    };

    emit(state.copyWith(filterStep: nextStep));
  }
}
