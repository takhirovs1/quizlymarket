import 'package:flutter/material.dart';

import '../extension/context_extension.dart';
import '../extension/int_extension.dart';
import '../util/dimension.dart';

class CustomCardWidget extends StatefulWidget {
  const CustomCardWidget({
    required this.subject,
    required this.university,
    required this.direction,
    required this.testCount,
    required this.year,
    required this.buttonText,
    required this.onPressed,
    this.price,
    super.key,
  });

  @override
  State<CustomCardWidget> createState() => _CustomCardWidgetState();

  final String subject;
  final String university;
  final String direction;
  final int testCount;
  final String year;
  final int? price;
  final String buttonText;
  final VoidCallback onPressed;
}

class _CustomCardWidgetState extends State<CustomCardWidget> {
  @override
  Widget build(BuildContext context) => Padding(
    padding: Dimension.pH16,
    child: DecoratedBox(
      decoration: const BoxDecoration(
        color: Color(0x14747480),
        borderRadius: Dimension.rAll16,
      ),
      child: Padding(
        padding: Dimension.pAll16,
        child: Column(
          spacing: 4,
          crossAxisAlignment: .start,
          children: [
            Row(
              mainAxisAlignment: .spaceBetween,
              crossAxisAlignment: .start,
              children: [
                Text(
                  widget.subject,
                  style: context.textTheme.sfProW500s16.copyWith(
                    color: context.color.black,
              fontWeight: FontWeight.w700,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  widget.university,
                  style: context.textTheme.sfProW500s16.copyWith(
                    color: context.color.gray,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            Text(
              widget.direction,
              style: context.textTheme.sfProW500s16.copyWith(
                color: context.color.gray,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              spacing: 10,
              children: [
                Text(
                  '${widget.testCount} ta savol',
                  style: context.textTheme.sfProW400s14.copyWith(
                    color: context.color.gray,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text('|', style: TextStyle(color: context.color.gray)),
                Text(
                  '2025-2026 yil',
                  style: context.textTheme.sfProW400s14.copyWith(
                    color: context.color.gray,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                if (widget.price != null)
                  Text(
                    widget.price?.toUZSString() ?? '',
                    style: context.textTheme.sfProW500s14.copyWith(
                      color: context.color.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                FilledButton(
                  style: FilledButton.styleFrom(
                    padding: Dimension.pH12V8,
                    backgroundColor: context.color.primary,
                  ),
                  onPressed: () {},
                  child: Text(
                    widget.buttonText,
                    style: context.textTheme.sfProW500s14.copyWith(
                      color: context.color.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
