import 'package:flutter/material.dart';

import 'test_init_enum.dart';

class CustomTestSettings {
  CustomTestSettings({
    required this.testMode,
    this.questionTime = QuestionTimeOption.seconds15,
    this.shuffleOption = ShuffleOption.all,
    this.questionRange = const RangeValues(0, 100),
    this.totalTestTime = TotalTestTimeOption.minutes30,
  });

  TestMode testMode;
  QuestionTimeOption questionTime;
  ShuffleOption shuffleOption;
  RangeValues questionRange;
  TotalTestTimeOption totalTestTime;

  CustomTestSettings copyWith({
    TestMode? testMode,
    QuestionTimeOption? questionTime,
    ShuffleOption? shuffleOption,
    RangeValues? questionRange,
    TotalTestTimeOption? totalTestTime,
  }) => CustomTestSettings(
    testMode: testMode ?? this.testMode,
    questionTime: questionTime ?? this.questionTime,
    shuffleOption: shuffleOption ?? this.shuffleOption,
    questionRange: questionRange ?? this.questionRange,
    totalTestTime: totalTestTime ?? this.totalTestTime,
  );
}
