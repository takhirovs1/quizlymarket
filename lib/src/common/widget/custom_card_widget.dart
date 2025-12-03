import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../constant/gen/assets.gen.dart';
import '../extension/context_extension.dart';
import '../extension/int_extension.dart';
import '../util/dimension.dart';

class CustomCardWidget extends StatefulWidget {
  const CustomCardWidget({
    required this.subject,
    required this.university,
    required this.direction,
    required this.testCount,
    required this.buttonText,
    required this.onPressed,
    required this.studyYears,
    this.price,
    super.key,
  });

  @override
  State<CustomCardWidget> createState() => _CustomCardWidgetState();

  final String subject;
  final String university;
  final String direction;
  final int testCount;
  final int? price;
  final String buttonText;
  final VoidCallback onPressed;
  final String studyYears;
}

class _CustomCardWidgetState extends State<CustomCardWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _linkCopyController;
  bool _isCopyAnimationReady = false;

  @override
  void initState() {
    super.initState();
    _linkCopyController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _linkCopyController.dispose();
    super.dispose();
  }

  void _replayCopyAnimation() {
    if (!_isCopyAnimationReady) return;
    if (_linkCopyController.isAnimating) {
      _linkCopyController.stop();
    }
    _linkCopyController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: Dimension.pH16,
    child: DecoratedBox(
      decoration: const BoxDecoration(color: Color(0x14747480), borderRadius: Dimension.rAll16),
      child: Padding(
        padding: Dimension.pAll16,
        child: Column(
          spacing: 4,
          crossAxisAlignment: .stretch,
          children: [
            Row(
              children: [
                // Lottie.asset('assets/lottie/book.json', width: 24, height: 24, repeat: false),
                Expanded(
                  child: Text(
                    widget.subject,
                    style: context.textTheme.sfProW500s16.copyWith(
                      color: context.color.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                Text(widget.university, style: context.textTheme.sfProW500s16.copyWith(color: context.color.gray)),
              ],
            ),

            Text(
              widget.direction,
              style: context.textTheme.sfProW500s16.copyWith(color: context.color.gray),
              maxLines: 2,
              overflow: .ellipsis,
            ),
            Row(
              spacing: 10,
              children: [
                Text(
                  '${widget.testCount} ta savol',
                  style: context.textTheme.sfProW400s14.copyWith(color: context.color.gray),
                  maxLines: 1,
                  overflow: .ellipsis,
                ),
                Text('|', style: TextStyle(color: context.color.gray)),
                Text(widget.studyYears, style: context.textTheme.sfProW400s14.copyWith(color: context.color.gray)),
              ],
            ),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                switch (widget.price != null) {
                  true => Row(
                    spacing: 4,
                    children: [
                      Lottie.asset(Assets.lottie.money, width: 24, height: 24, repeat: false),
                      Text(
                        widget.price?.toUZSString() ?? '',
                        style: context.textTheme.sfProW500s14.copyWith(
                          color: context.color.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  false => const SizedBox.shrink(),
                },
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.telegramWebApp.hapticFeedback.impactOccurred(.light);
                        _replayCopyAnimation();
                      },
                      icon: Lottie.asset(
                        Assets.lottie.linkcopy,
                        width: 24,
                        height: 24,
                        repeat: false,
                        controller: _linkCopyController,
                        onLoaded: (composition) {
                          _linkCopyController
                            ..duration = composition.duration
                            ..forward(from: 0);
                          _isCopyAnimationReady = true;
                        },
                      ),
                    ),
                    Dimension.wBox4,
                    FilledButton(
                      style: FilledButton.styleFrom(padding: Dimension.pH12V8, backgroundColor: context.color.primary),
                      onPressed: () {
                        context.telegramWebApp.hapticFeedback.impactOccurred(.light);
                        widget.onPressed();
                      },
                      child: Text(
                        widget.buttonText,
                        style: context.textTheme.sfProW500s14.copyWith(color: context.color.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
