part of 'test_bloc.dart';

class TestState extends Equatable {
  const TestState({
    this.status = Status.initial,
    this.tests = const [
      QuestionModel(
        id: '1',
        testId: '1',
        question: 'Оммавий ахборот воситалари орқали ёритиш',
        answers: [
          AnswerModel(id: '1', questionId: '1', answer: 'answer 1', isCorrect: true),
          AnswerModel(id: '2', questionId: '1', answer: 'answer 2', isCorrect: false),
          AnswerModel(id: '3', questionId: '1', answer: 'answer 3', isCorrect: false),
          AnswerModel(id: '4', questionId: '1', answer: 'answer 4', isCorrect: false),
        ],
      ),
      QuestionModel(
        id: '2',
        testId: '1',
        question: 'Касбий компетенциялар қандай ҳолларда иш жойида муваффақиятга эришишга ёрдам беради?',
        answers: [
          AnswerModel(
            id: '1',
            questionId: '2',
            answer: 'Иш жойида муваффақиятга эришишга ёрдам беради',
            isCorrect: true,
          ),
          AnswerModel(
            id: '2',
            questionId: '2',
            answer: 'Иш жойида муваффақиятга эришишга ёрдам беради',
            isCorrect: false,
          ),
          AnswerModel(
            id: '3',
            questionId: '2',
            answer: 'Иш жойида муваффақиятга эришишга ёрдам беради',
            isCorrect: false,
          ),
          AnswerModel(
            id: '4',
            questionId: '2',
            answer: 'Иш жойида муваффақиятга эришишга ёрдам беради',
            isCorrect: false,
          ),
        ],
      ),
      QuestionModel(
        id: '3',
        testId: '1',
        question: 'Касбий компетенциялар қандай ҳолларда иш жойида муваффақиятга эришишга ёрдам беради?',
        answers: [
          AnswerModel(id: '1', questionId: '3', answer: 'answer 1', isCorrect: true),
          AnswerModel(id: '2', questionId: '3', answer: 'answer 2', isCorrect: false),
          AnswerModel(id: '3', questionId: '3', answer: 'answer 3', isCorrect: false),
          AnswerModel(id: '4', questionId: '3', answer: 'answer 4', isCorrect: false),
        ],
      ),
      QuestionModel(
        id: '4',
        testId: '1',
        question: 'Касбий компетенциялар қандай ҳолларда иш жойида муваффақиятга эришишга ёрдам беради?',
        answers: [
          AnswerModel(id: '1', questionId: '4', answer: 'answer 1', isCorrect: true),
          AnswerModel(id: '2', questionId: '4', answer: 'answer 2', isCorrect: false),
          AnswerModel(id: '3', questionId: '4', answer: 'answer 3', isCorrect: false),
          AnswerModel(id: '4', questionId: '4', answer: 'answer 4', isCorrect: false),
        ],
      ),
      QuestionModel(
        id: '5',
        testId: '1',
        question: 'Касбий компетенциялар қандай ҳолларда иш жойида муваффақиятга эришишга ёрдам беради?',
        answers: [
          AnswerModel(id: '1', questionId: '5', answer: 'answer 1', isCorrect: true),
          AnswerModel(id: '2', questionId: '5', answer: 'answer 2', isCorrect: false),
          AnswerModel(id: '3', questionId: '5', answer: 'answer 3', isCorrect: false),
          AnswerModel(id: '4', questionId: '5', answer: 'answer 4', isCorrect: false),
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

  TestState copyWith({Status? status, List<QuestionModel>? tests, int? currentQuestionIndex, bool? revealAnswer}) => TestState(
    status: status ?? this.status,
    tests: tests ?? this.tests,
    currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
    revealAnswer: revealAnswer ?? this.revealAnswer,
  );
}
