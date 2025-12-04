import 'package:flutter/material.dart';

import '../../../../../common/constant/gen/assets.gen.dart';
import '../../../../../common/extension/context_extension.dart';
import '../../../../../common/util/dimension.dart';
import '../../../../../common/widget/custom_bottom_sheet.dart';
import '../../../../../common/widget/custom_button.dart';
import '../../data/model/home_default_model.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({required this.universities, super.key});
  final List<UniversityModel> universities;

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  @override
  Widget build(BuildContext context) => CustomBottomSheet(
    isScrollable: true,
    maxChildSize: .9,
    initialChildSize: .9,
    bottomNavigationBar: CustomButton(onRightPressed: context.pop, rightText: context.l10n.filter),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(onTap: () {}, child: Assets.vectors.arrowBack.svg()),
        Text(context.l10n.addToHomeScreenApp, style: context.textTheme.nunitoW600s18),
      ],
    ),
    children: [
      ListView.separated(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: 10,
        separatorBuilder: (context, index) => Dimension.hBox10,
        itemBuilder: (context, index) => Material(
          color: context.color.transparent,
          child: InkWell(
            hoverColor: context.color.transparent,
            borderRadius: Dimension.rAll6,
            onTap: context.pop,

            child: DecoratedBox(
              decoration: BoxDecoration(borderRadius: Dimension.rAll6, color: context.color.cardBackground),

              child: Padding(
                padding: Dimension.pAll14,
                child: Text(
                  'salom',
                  style: index != 0 ? context.textTheme.nunitoW400s16 : context.textTheme.nunitoW600s16,
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
