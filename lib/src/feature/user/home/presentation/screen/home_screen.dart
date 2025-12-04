import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../../common/constant/gen/assets.gen.dart';
import '../../../../../common/extension/context_extension.dart';
// import '../../../../../common/model/test_model.dart';
import '../../../../../common/util/dimension.dart';
import '../../../../../common/widget/custom_card_widget.dart';
import '../../../../../common/widget/custom_text_filed.dart';
import '../../../../tests/model/test_model.dart';
import '../state/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends HomeState {
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: context.color.background,
    body: SafeArea(
      child: ListView(
        padding: Dimension.pAll16,

        children: [
          CustomTextFiled(
            hintText: context.l10n.search,

            action: IconButton(
              hoverColor: context.color.transparent,
              onPressed: onFilterButtonPressed,
              icon: Lottie.asset(Assets.lottie.filter, width: 24, height: 24, repeat: false),

              // icon: Lottie.asset(Assets.lottie.filter, width: 30, height: 30, fit: BoxFit.scaleDown, repeat: false),
            ),
          ),

          Dimension.hBox16,
          FutureBuilder(
            future: context.dependencies.repository.testsRepository.getTests(),
            builder: (context, snapshot) => switch ((snapshot.data, snapshot.error)) {
              (final List<TestModel> tests, null) => ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final test = tests[index];
                  return CustomCardWidget(
                    subject: test.subject.name,
                    university: test.subject.direction.course.faculty.university.name,
                    direction: test.subject.direction.name,
                    testCount: test.questionCount,
                    studyYears: test.academicYearSemesterText,
                    price: test.price,
                    buttonText: context.l10n.buy,
                    onPressed: onBuyButtonPressed,
                  );
                },
                separatorBuilder: (context, index) => Dimension.hBox12,
                itemCount: tests.length,
              ),
              // TODO: Error case
              (null, Object? error) => Text(error.toString()),
              // TODO: Loading case
              _ => const SizedBox.shrink(),
            },
          ),
        ],
      ),
    ),
  );
}
