import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../../common/constant/gen/assets.gen.dart';
import '../../../../../common/extension/context_extension.dart';
// import '../../../../../common/model/test_model.dart';
import '../../../../../common/util/dimension.dart';
import '../../../../../common/widget/custom_card_widget.dart';
import '../../../../../common/widget/custom_text_filed.dart';
import '../../../../tests/bloc/tests_bloc.dart';
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
      child: Column(
        children: [
          Padding(
            padding: Dimension.pAll16,
            child: CustomTextFiled(
              hintText: context.l10n.search,

              action: IconButton(
                hoverColor: context.color.transparent,
                onPressed: onFilterButtonPressed,
                icon: Lottie.asset(Assets.lottie.filter, width: 24, height: 24, repeat: false),

                // icon: Lottie.asset(Assets.lottie.filter, width: 30, height: 30, fit: BoxFit.scaleDown, repeat: false),
              ),
            ),
          ),

          // TODO(Samandar): UI ni chiroyli qilib to'g'rilash kerak
          Expanded(
            child: BlocBuilder<TestsBloc, TestsState>(
              builder: (context, state) => state.when(
                initial: () => const Center(child: CircularProgressIndicator()),
                loading: () => const Center(child: CircularProgressIndicator()),
                empty: () => Center(child: Text(context.l10n.noTestsFound)),
                success: (tests) => ListView.separated(
                  padding: Dimension.pH16Bottom16,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final test = tests[0];
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
                  itemCount: 20,
                ),
                error: (error) => Text(error.toString()),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
