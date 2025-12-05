import 'package:flutter/material.dart';

import '../../../../../common/extension/context_extension.dart';
import '../../../../../common/util/dimension.dart';
import '../../../../../common/widget/custom_button.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  UploadType uploadType = .university;
  String selectedUniversity = '';
  String selectedFaculty = '';
  String selectedCourse = '';
  String selectedSubject = '';
  final List<String> universities = [
    'Alfraganus',
    'Toshkent davlat Iqtisodiyot University',
    'Toshkent davlat Yuridik University',
    'WUIT',
  ];
  final List<String> faculties = [
    'Faculty of Economics',
    'Faculty of Medicine',
    'Faculty of Social Sciences',
    'Faculty of Philology',
  ];
  final List<String> courses = ['1-kurs', '2-kurs', '3-kurs', '4-kurs'];
  final List<String> subjects = [
    'Economy',
    'World economy and international economy',
    'Finance and financial technologies',
    'Taxes and taxation',
    'Accounting',
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Padding(
      padding: Dimension.pAll16,
      child: switch (uploadType) {
        .faculty => Column(
          crossAxisAlignment: .stretch,
          children: [
            Text('Faculties', style: context.textTheme.sfProW500s24),
            Dimension.hBox16,
            for (final i in faculties) ...[
              GestureDetector(
                onTap: () => setState(() => selectedFaculty = i),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: selectedFaculty == i ? context.color.primary : context.color.cardBackground,
                    borderRadius: Dimension.rAll16,
                  ),
                  child: Padding(
                    padding: Dimension.pAll14,
                    child: Text(
                      i,
                      style: context.textTheme.sfProW400s18.copyWith(
                        color: selectedFaculty == i ? context.color.onPrimary : context.color.black,
                      ),
                    ),
                  ),
                ),
              ),
              Dimension.hBox8,
            ],
          ],
        ),
        .course => Column(
          crossAxisAlignment: .stretch,
          children: [
            Text('Courses', style: context.textTheme.sfProW500s24),
            Dimension.hBox16,
            for (final i in courses) ...[
              GestureDetector(
                onTap: () => setState(() => selectedCourse = i),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: selectedCourse == i ? context.color.primary : context.color.cardBackground,
                    borderRadius: Dimension.rAll16,
                  ),
                  child: Padding(
                    padding: Dimension.pAll14,
                    child: Text(
                      i,
                      style: context.textTheme.sfProW400s18.copyWith(
                        color: selectedCourse == i ? context.color.onPrimary : context.color.black,
                      ),
                    ),
                  ),
                ),
              ),
              Dimension.hBox8,
            ],
          ],
        ),
        .subject => Column(
          crossAxisAlignment: .stretch,
          children: [
            Text('Subjects', style: context.textTheme.sfProW500s24),
            Dimension.hBox16,
            for (final i in subjects) ...[
              GestureDetector(
                onTap: () => setState(() => selectedSubject = i),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: selectedSubject == i ? context.color.primary : context.color.cardBackground,
                    borderRadius: Dimension.rAll16,
                  ),
                  child: Padding(
                    padding: Dimension.pAll14,
                    child: Text(
                      i,
                      style: context.textTheme.sfProW400s18.copyWith(
                        color: selectedSubject == i ? context.color.onPrimary : context.color.black,
                      ),
                    ),
                  ),
                ),
              ),
              Dimension.hBox8,
            ],
          ],
        ),
        _ => Column(
          crossAxisAlignment: .stretch,
          children: [
            Text(context.l10n.testModeUniversity, style: context.textTheme.sfProW500s24),
            Dimension.hBox16,
            for (final i in universities) ...[
              GestureDetector(
                onTap: () => setState(() => selectedUniversity = i),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: selectedUniversity == i ? context.color.primary : context.color.cardBackground,
                    borderRadius: Dimension.rAll16,
                  ),
                  child: Padding(
                    padding: Dimension.pAll14,
                    child: Text(
                      i,
                      style: context.textTheme.sfProW400s18.copyWith(
                        color: selectedUniversity == i ? context.color.onPrimary : context.color.black,
                      ),
                    ),
                  ),
                ),
              ),
              Dimension.hBox8,
            ],
          ],
        ),
      },
    ),
    bottomNavigationBar: Padding(
      padding: Dimension.pAll16,
      child: CustomButton(
        onRightPressed: () {
          if (uploadType.isUniversity) {
            setState(() => uploadType = .faculty);
          } else if (uploadType.isFaculty) {
            setState(() => uploadType = .course);
          } else if (uploadType.isCourse) {
            setState(() => uploadType = .subject);
          } else if (uploadType.isSubject) {
            setState(() => uploadType = .university);
          }
        },
        rightText: 'Next',
      ),
    ),
  );
}

enum UploadType {
  university,
  faculty,
  course,
  subject;

  bool get isUniversity => this == .university;
  bool get isFaculty => this == .faculty;
  bool get isCourse => this == .course;
  bool get isSubject => this == .subject;
}
