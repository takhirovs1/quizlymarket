part of 'test_bloc.dart';

class TestState extends Equatable {
  const TestState({
    this.status = Status.initial,
    this.tests = const [
      QuestionModel(
        id: '1',
        testId: '1',
        question: 'Академик коммуникация деганда нима тушунилади?',
        answers: [
          AnswerModel(id: '1', questionId: '1', answer: 'Оммавий ахборот воситалари орқали ёритиш', isCorrect: true),
          AnswerModel(id: '2', questionId: '1', answer: 'Билим, кўникмалар ва қобилиятлар', isCorrect: false),
          AnswerModel(
            id: '3',
            questionId: '1',
            answer: 'Фақат фаолиятнинг энг юқори даражасидаги мутахассислар ўртасида алоқа',
            isCorrect: false,
          ),
          AnswerModel(
            id: '4',
            questionId: '1',
            answer: 'Ҳар қандай маълумотни ёзиш ва унинг тарқатилиши',
            isCorrect: false,
          ),
        ],
      ),
      QuestionModel(
        id: '2',
        testId: '1',
        question: 'Профессионал компетентликнинг асосий компонентлари қуйидагилардан қайси бири?',
        answers: [
          AnswerModel(id: '1', questionId: '2', answer: 'Билим, кўникмалар ва қобилиятлар', isCorrect: true),
          AnswerModel(id: '2', questionId: '2', answer: 'Хатоликларни тўғрилаш', isCorrect: false),
          AnswerModel(id: '3', questionId: '2', answer: 'Таълим фақат ўз соҳасида', isCorrect: false),
          AnswerModel(id: '4', questionId: '2', answer: 'Ҳар қандай иш жараёнига бўлган қизиқиш', isCorrect: false),
        ],
      ),
      QuestionModel(
        id: '3',
        testId: '1',
        question: 'Академик ахлоқнинг асосий талаблари қуйидагилардан қайси бири?',
        answers: [
          AnswerModel(id: '1', questionId: '3', answer: 'Плагият ва манбаа нишонларини ҳисобга олиш', isCorrect: true),
          AnswerModel(id: '2', questionId: '3', answer: 'Ҳар қандай манбаани ижобий ёзиш', isCorrect: false),
          AnswerModel(
            id: '3',
            questionId: '3',
            answer: 'Илмий тадқиқотларда ўз фикрингизни шакллантириш',
            isCorrect: false,
          ),
          AnswerModel(
            id: '4',
            questionId: '3',
            answer: 'Фақат бир ойлик назарий тадқиқотларни амалга ошириш',
            isCorrect: false,
          ),
        ],
      ),
      QuestionModel(
        id: '4',
        testId: '1',
        question: 'Критик фикрлашнинг асосий элементлари қандай?',
        answers: [
          AnswerModel(id: '1', questionId: '4', answer: 'Маълумотларни таҳлил қилиш ва баҳолаш', isCorrect: true),
          AnswerModel(id: '2', questionId: '4', answer: 'Тахмин ва гипотеза қуриш', isCorrect: false),
          AnswerModel(id: '3', questionId: '4', answer: 'Одамларнинг ҳис-туйғуларини тушуниш', isCorrect: false),
          AnswerModel(id: '4', questionId: '4', answer: 'Бошқаларнинг фикрларини баҳолаш', isCorrect: false),
        ],
      ),
      QuestionModel(
        id: '5',
        testId: '1',
        question: 'Академик ёзувда манбааларни тўғри кўрсатишнинг аҳамияти нимада?',
        answers: [
          AnswerModel(id: '1', questionId: '5', answer: 'Плагиятдан сақланиш', isCorrect: true),
          AnswerModel(
            id: '2',
            questionId: '5',
            answer: 'Матннинг аниқ ва тушунарли бўлишини таъминлаш',
            isCorrect: false,
          ),
          AnswerModel(id: '3', questionId: '5', answer: 'Фақат асосий манбаа билан ишлаш', isCorrect: false),
          AnswerModel(id: '4', questionId: '5', answer: 'Йўқолган манбааларни аниқлаш', isCorrect: false),
        ],
      ),
    ],
    this.currentQuestionIndex = 0,
    this.revealAnswer = false,
  });

  final Status status;
  final List<QuestionModel> tests;
  final int currentQuestionIndex;
  final bool revealAnswer;

  @override
  List<Object?> get props => [status, tests, currentQuestionIndex, revealAnswer];

  TestState copyWith({Status? status, List<QuestionModel>? tests, int? currentQuestionIndex, bool? revealAnswer}) =>
      TestState(
        status: status ?? this.status,
        tests: tests ?? this.tests,
        currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
        revealAnswer: revealAnswer ?? this.revealAnswer,
      );
}
