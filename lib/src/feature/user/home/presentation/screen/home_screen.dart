import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../../common/constant/gen/assets.gen.dart';
import '../../../../../common/extension/context_extension.dart';
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
      child: BlocBuilder<TestsBloc, TestsState>(
        builder: (context, state) =>
            CustomScrollView(slivers: [_buildSearchSliver(context), ..._buildStateSlivers(context, state)]),
      ),
    ),
  );

  SliverPadding _buildSearchSliver(BuildContext context) => SliverPadding(
    padding: Dimension.pAll16,
    sliver: SliverToBoxAdapter(
      child: CustomTextFiled(
        hintText: context.l10n.search,
        controller: searchController,
        onChanged: (value) {
          context.read<TestsBloc>().add(GetTestsEvent(search: value));
        },
        action: IconButton(
          hoverColor: context.color.transparent,
          onPressed: onFilterButtonPressed,
          icon: Lottie.asset(Assets.lottie.filter, width: 24, height: 24, repeat: false),
        ),
      ),
    ),
  );

  List<Widget> _buildStateSlivers(BuildContext context, TestsState state) => state.when(
    initial: () => [_buildLoadingSliver()],
    loading: () => [_buildLoadingSliver()],
    empty: () => [_buildMessageSliver(context.l10n.noTestsFound)],
    success: (tests) => [_buildTestsSliver(context, tests)],
    error: (error) => [_buildMessageSliver(error?.toString() ?? 'Something went wrong')],
  );

  Widget _buildLoadingSliver() =>
      const SliverFillRemaining(hasScrollBody: false, child: Center(child: CircularProgressIndicator()));

  Widget _buildMessageSliver(String message) => SliverFillRemaining(
    hasScrollBody: false,
    child: Center(child: Text(message, textAlign: TextAlign.center)),
  );

  Widget _buildTestsSliver(BuildContext context, List<TestModel> tests) => SliverPadding(
    padding: Dimension.pH16Bottom16,
    sliver: SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final test = tests[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomCardWidget(
              title: test.title,
              subject: test.subject.name,
              university: test.subject.direction.course.faculty.university.name,
              direction: test.subject.direction.name,
              testCount: test.questionCount,
              studyYears: test.academicYearSemesterText,
              price: test.price,
              buttonText: context.l10n.buy,
              onPressed: () => onBuyButtonPressed(test),
            ),
            if (index != tests.length - 1) Dimension.hBox12,
          ],
        );
      }, childCount: tests.length),
    ),
  );
}
