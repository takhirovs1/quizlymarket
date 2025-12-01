enum TestMode { custom, university }

enum QuestionTimeOption {
  seconds15('15s', Duration(seconds: 15)),
  seconds30('30s', Duration(seconds: 30)),
  seconds45('45s', Duration(seconds: 45)),
  minute1('1min', Duration(minutes: 1)),
  minutes2('2min', Duration(minutes: 2)),
  minutes3('3min', Duration(minutes: 3));

  const QuestionTimeOption(this.label, this.duration);

  final String label;
  final Duration duration;
}

enum ShuffleOption { all, none, questionsOnly, answersOnly }

enum TotalTestTimeOption {
  minutes30(Duration(minutes: 30)),
  hour1(Duration(hours: 1));

  const TotalTestTimeOption(this.duration);

  final Duration duration;
}
