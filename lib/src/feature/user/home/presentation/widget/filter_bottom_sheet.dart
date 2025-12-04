import 'package:flutter/cupertino.dart';

import '../../../../../common/extension/context_extension.dart';
import '../../../../../common/util/dimension.dart';
import '../../../../../common/widget/custom_bottom_sheet.dart';
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
    maxChildSize: .5,
    initialChildSize: .5,

    title: Text(context.l10n.addToHomeScreenApp),
    children: [Text('')],
  );
}
