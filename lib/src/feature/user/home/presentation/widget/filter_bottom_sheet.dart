import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/constant/gen/assets.gen.dart';
import '../../../../../common/enum/bloc_status_enum.dart';
import '../../../../../common/enum/filter_step_enum.dart';
import '../../../../../common/extension/context_extension.dart';
import '../../../../../common/util/dimension.dart';
import '../../../../../common/widget/custom_bottom_sheet.dart';
import '../../../../../common/widget/custom_button.dart';
import '../bloc/filter/filter_bloc.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  Widget getListByStep(BuildContext context, FilterState state) => switch (state.filterStep) {
    FilterStep.university => buildList(
      state.university,
      (u, index) => Text(u.name, style: context.textTheme.nunitoW400s16),
      (u) => context.read<FilterBloc>().add(FilterFacultyEvent(universityModel: u)),
    ),
    FilterStep.faculty => buildList(
      state.faculty,
      (f, index) => Text(f.name, style: index == 0 ? context.textTheme.nunitoW600s16 : context.textTheme.nunitoW400s16),
      (f) => context.read<FilterBloc>().add(FilterCourseEvent(facultyModel: f)),
    ),
    FilterStep.course => buildList(
      state.course,
      (c, index) => Text(c.name, style: index == 0 ? context.textTheme.nunitoW600s16 : context.textTheme.nunitoW400s16),
      (c) => context.read<FilterBloc>().add(FilterDirectionEvent(courseModel: c)),
    ),
    FilterStep.direction => buildList(
      state.direction,
      (d, index) => Text(d.name, style: index == 0 ? context.textTheme.nunitoW600s16 : context.textTheme.nunitoW400s16),
      (d) => context.pop(d),
    ),
  };

  // ignore: inference_failure_on_function_return_type
  Widget buildList<T>(List<T> list, Widget Function(T, int) itemBuilder, Function(T) onTap) => ListView.separated(
    shrinkWrap: true,
    physics: const ClampingScrollPhysics(),
    itemCount: list.length,
    separatorBuilder: (context, index) => Dimension.hBox10,
    itemBuilder: (context, index) {
      final item = list[index];
      return Material(
        color: context.color.transparent,
        child: InkWell(
          hoverColor: context.color.transparent,
          borderRadius: Dimension.rAll6,
          onTap: () => onTap(item),
          child: DecoratedBox(
            decoration: BoxDecoration(borderRadius: Dimension.rAll6, color: context.color.cardBackground),
            child: Padding(padding: Dimension.pAll14, child: itemBuilder(item, index)),
          ),
        ),
      );
    },
  );

  @override
  Widget build(BuildContext context) => CustomBottomSheet(
    isScrollable: true,
    maxChildSize: .9,
    initialChildSize: .9,
    bottomNavigationBar: CustomButton(onRightPressed: context.pop, rightText: context.l10n.filter),
    title: BlocBuilder<FilterBloc, FilterState>(
      builder: (context, state) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (state.filterStep != FilterStep.university)
            GestureDetector(
              onTap: () => context.read<FilterBloc>().add(FilterBackEvent()),
              child: Assets.vectors.arrowBack.svg(),
            ),
          Text('Default', style: context.textTheme.nunitoW600s18),
        ],
      ),
    ),
    children: [
      BlocBuilder<FilterBloc, FilterState>(
        builder: (context, state) => switch (state.filterStatus) {
          Status.loading => const Center(child: CircularProgressIndicator()),
          Status.success => getListByStep(context, state),
          Status.error => Center(
            child: Text(state.error, style: context.textTheme.nunitoW400s16.copyWith(color: context.color.onSurface)),
          ),
          _ => const SizedBox.shrink(),
        },
      ),
    ],
  );

  //  BlocBuilder<FilterBloc, FilterState>(
  //   builder: (context, state) => switch (state.filterStatus) {
  //     Status.loading => const Center(child: CircularProgressIndicator()),
  //     Status.success => ,
  //     Status.error => Center(
  //       child: Text(state.error, style: context.textTheme.nunitoW400s16.copyWith(color: context.color.onSurface)),
  //     ),
  //     _ => const SizedBox.shrink(),
  //   },
  // );
}
