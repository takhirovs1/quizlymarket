import 'package:flutter/material.dart';

import '../../../../../common/extension/context_extension.dart';
import '../../../../../common/util/dimension.dart';
import '../../../../../common/widget/custom_bottom_sheet.dart';
import '../../../../../common/widget/custom_button.dart';
import '../../data/model/home_default_model.dart';

enum FilterStep { university, faculty, course, direction }

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({required this.universities, super.key});
  final List<UniversityModel> universities;

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  FilterStep currentStep = FilterStep.university;
  int? selectedUniversityIndex;
  int? selectedFacultyIndex;
  int? selectedCourseIndex;

  void onStepChanged(int index) {
    setState(() {
      switch (currentStep) {
        case FilterStep.university:
          currentStep = FilterStep.faculty;
          selectedUniversityIndex = index;
          selectedFacultyIndex = null;
          selectedCourseIndex = null;
          return;
        case FilterStep.faculty:
          currentStep = FilterStep.course;
          selectedFacultyIndex = index;
          selectedCourseIndex = null;
          return;
        case FilterStep.course:
          currentStep = FilterStep.direction;
          selectedCourseIndex = index;
          return;
        case FilterStep.direction:
          context.pop();
          return;
      }
    });
  }

  void onBackPressed() {
    setState(() {
      switch (currentStep) {
        case FilterStep.faculty:
          currentStep = FilterStep.university;
          selectedFacultyIndex = null;
          selectedCourseIndex = null;
          return;
        case FilterStep.course:
          currentStep = FilterStep.faculty;
          selectedCourseIndex = null;
          return;
        case FilterStep.direction:
          currentStep = FilterStep.course;
          return;
        case FilterStep.university:
          context.pop();
          return;
      }
    });
  }

  String _titleText() {
    if (currentStep == FilterStep.university) {
      return 'University';
    }
    final university = selectedUniversityIndex != null ? widget.universities[selectedUniversityIndex!] : null;
    final faculty = (university != null && selectedFacultyIndex != null)
        ? university.faculties[selectedFacultyIndex!]
        : null;
    final course = (faculty != null && selectedCourseIndex != null) ? faculty.courses[selectedCourseIndex!] : null;
    return switch (currentStep) {
      FilterStep.faculty => university?.name ?? '',
      FilterStep.course => faculty?.name ?? '',
      FilterStep.direction => course?.name ?? '',
      FilterStep.university => '',
    };
  }

  @override
  Widget build(BuildContext context) => CustomBottomSheet(
    isScrollable: true,
    initialChildSize: 0.9,
    maxChildSize: 0.9,
    bottomNavigationBar: currentStep == FilterStep.university
        ? null
        : CustomButton(onRightPressed: () {}, rightText: context.l10n.filter),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            if (currentStep != FilterStep.university)
              IconButton(onPressed: onBackPressed, icon: const Icon(Icons.arrow_back)),
            Text(_titleText(), style: context.textTheme.nunitoW600s22, textAlign: TextAlign.left),
          ],
        ),
      ],
    ),
    children: [
      IndexedStack(
        index: currentStep.index,
        children: [
          UniversityList(universities: widget.universities, onTap: onStepChanged),

          FacultyWidget(
            faculties: selectedUniversityIndex == null
                ? const []
                : widget.universities[selectedUniversityIndex!].faculties,
            onTap: onStepChanged,
          ),

          CourseList(
            courses: selectedUniversityIndex == null || selectedFacultyIndex == null
                ? const []
                : widget.universities[selectedUniversityIndex!].faculties[selectedFacultyIndex!].courses,
            onTap: onStepChanged,
          ),

          DirectionList(
            directions: selectedUniversityIndex == null || selectedFacultyIndex == null || selectedCourseIndex == null
                ? const []
                : widget
                      .universities[selectedUniversityIndex!]
                      .faculties[selectedFacultyIndex!]
                      .courses[selectedCourseIndex!]
                      .directions,
            onTap: onStepChanged,
          ),
        ],
      ),
    ],
  );
}

class UniversityList extends StatelessWidget {
  const UniversityList({required this.universities, required this.onTap, super.key});

  final List<UniversityModel> universities;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) => ListView.separated(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: universities.length,
    separatorBuilder: (context, index) => Dimension.hBox10,
    itemBuilder: (context, index) => Material(
      color: context.color.transparent,
      child: InkWell(
        hoverColor: context.color.transparent,
        borderRadius: Dimension.rAll16,
        onTap: () => onTap(index),
        child: Ink(
          decoration: BoxDecoration(borderRadius: Dimension.rAll16, color: context.color.cardBackground),
          child: Padding(
            padding: Dimension.pAll14,
            child: Text(universities[index].name, style: context.textTheme.nunitoW400s18),
          ),
        ),
      ),
    ),
  );
}

class FacultyWidget extends StatelessWidget {
  const FacultyWidget({required this.faculties, required this.onTap, super.key});

  final List<FacultyModel> faculties;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) => ListView.separated(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: faculties.length,
    separatorBuilder: (context, index) => Dimension.hBox10,
    itemBuilder: (context, index) => Material(
      color: context.color.transparent,
      child: InkWell(
        hoverColor: context.color.transparent,
        borderRadius: Dimension.rAll16,
        onTap: () => index == 0 ? null : onTap(index),
        child: Ink(
          decoration: BoxDecoration(borderRadius: Dimension.rAll16, color: context.color.cardBackground),
          child: Padding(
            padding: Dimension.pAll14,
            child: Text(
              faculties[index].name,
              style: index == 0 ? context.textTheme.nunitoW600s18 : context.textTheme.nunitoW400s18,
            ),
          ),
        ),
      ),
    ),
  );
}

class CourseList extends StatelessWidget {
  const CourseList({required this.courses, required this.onTap, super.key});

  final List<CourseModel> courses;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) => ListView.separated(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: courses.length,
    separatorBuilder: (context, index) => Dimension.hBox10,
    itemBuilder: (context, index) => Material(
      color: context.color.transparent,
      child: InkWell(
        hoverColor: context.color.transparent,
        borderRadius: Dimension.rAll16,
        onTap: () => index == 0 ? null : onTap(index),
        child: Ink(
          decoration: BoxDecoration(borderRadius: Dimension.rAll16, color: context.color.cardBackground),
          child: Padding(
            padding: Dimension.pAll14,
            child: Text(
              courses[index].name,
              style: index == 0 ? context.textTheme.nunitoW600s18 : context.textTheme.nunitoW400s18,
            ),
          ),
        ),
      ),
    ),
  );
}

class DirectionList extends StatelessWidget {
  const DirectionList({required this.directions, required this.onTap, super.key});

  final List<DirectionModel> directions;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) => ListView.separated(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: directions.length,
    separatorBuilder: (context, index) => Dimension.hBox10,
    itemBuilder: (context, index) => Material(
      color: context.color.transparent,
      child: InkWell(
        hoverColor: context.color.transparent,
        borderRadius: Dimension.rAll16,
        onTap: () => index == 0 ? null : onTap(index),
        child: Ink(
          decoration: BoxDecoration(borderRadius: Dimension.rAll16, color: context.color.cardBackground),
          child: Padding(
            padding: Dimension.pAll14,
            child: Text(
              directions[index].name,
              style: index == 0 ? context.textTheme.nunitoW600s18 : context.textTheme.nunitoW400s18,
            ),
          ),
        ),
      ),
    ),
  );
}
