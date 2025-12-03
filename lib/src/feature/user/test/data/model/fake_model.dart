import '../../../../../common/model/test_model.dart';

class FakeModel {
  static const List<QuestionModel> questions = [
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

    // 6
    QuestionModel(
      id: '6',
      testId: '1',
      question: 'Профессионал этика деганда нима тушунилади?',
      answers: [
        AnswerModel(id: '1', questionId: '6', answer: 'Касбий фаолиятда ахлоқий нормаларни бажариш', isCorrect: true),
        AnswerModel(id: '2', questionId: '6', answer: 'Маълумотлар алмашинувининг аниқлиги', isCorrect: false),
        AnswerModel(id: '3', questionId: '6', answer: 'Оммавий ахборот билан ишлаш', isCorrect: false),
        AnswerModel(id: '4', questionId: '6', answer: 'Маълумотларни тез тарқатиш', isCorrect: false),
      ],
    ),
    QuestionModel(
      id: '7',
      testId: '1',
      question: 'Академик ёзувда структуранинг аҳамияти қандай?',
      answers: [
        AnswerModel(
          id: '1',
          questionId: '7',
          answer: 'Тўғри тузилиш ва фикрлар узвийлигини таъминлаш',
          isCorrect: true,
        ),
        AnswerModel(id: '2', questionId: '7', answer: 'Кўп маълумотни жойлаштириш', isCorrect: false),
        AnswerModel(id: '3', questionId: '7', answer: 'Матнни қисқартириш', isCorrect: false),
        AnswerModel(id: '4', questionId: '7', answer: 'Янгиликлар киритиш', isCorrect: false),
      ],
    ),
    QuestionModel(
      id: '8',
      testId: '1',
      question: 'Академик мақола ишлаб чиқишда қайси элемент муҳим?',
      answers: [
        AnswerModel(id: '1', questionId: '8', answer: 'Илмий ахборотга асосланган изланишлар', isCorrect: true),
        AnswerModel(id: '2', questionId: '8', answer: 'Рангли диаграммалар', isCorrect: false),
        AnswerModel(id: '3', questionId: '8', answer: 'Тезкор фикрлар', isCorrect: false),
        AnswerModel(id: '4', questionId: '8', answer: 'Фақат китоблар билан ишлаш', isCorrect: false),
      ],
    ),
    QuestionModel(
      id: '9',
      testId: '1',
      question: '“Компетенция” тушунчаси қандай?',
      answers: [
        AnswerModel(
          id: '1',
          questionId: '9',
          answer: 'Касбий фаолиятдаги зарур билимлар ва кўникмалар',
          isCorrect: true,
        ),
        AnswerModel(id: '2', questionId: '9', answer: 'Ўрганиш жараёни', isCorrect: false),
        AnswerModel(id: '3', questionId: '9', answer: 'Ишдаги хусусий ишонч', isCorrect: false),
        AnswerModel(id: '4', questionId: '9', answer: 'Бошқа соҳалардан олинган билимлар', isCorrect: false),
      ],
    ),
    QuestionModel(
      id: '10',
      testId: '1',
      question: 'Академик ёзувда ишлатиш учун қандай манбаалар танланади?',
      answers: [
        AnswerModel(id: '1', questionId: '10', answer: 'Маълумотларнинг ишончли ва аниқ манбаалари', isCorrect: true),
        AnswerModel(id: '2', questionId: '10', answer: 'Тўлиқ ёзилмаган манбаалар', isCorrect: false),
        AnswerModel(id: '3', questionId: '10', answer: 'Фақат бир кишидан олинган манбаа', isCorrect: false),
        AnswerModel(id: '4', questionId: '10', answer: 'Мустақил ва ёзилган сўзлар', isCorrect: false),
      ],
    ),
    QuestionModel(
      id: '11',
      testId: '1',
      question: 'Профессионал компетентликни ошириш учун қайси тадбирлар фойда келтиради?',
      answers: [
        AnswerModel(
          id: '1',
          questionId: '11',
          answer: 'Касбий билим ва кўникмаларни мунтазам янгилаш',
          isCorrect: true,
        ),
        AnswerModel(id: '2', questionId: '11', answer: 'Ҳар қандай фанга қизиқиш', isCorrect: false),
        AnswerModel(id: '3', questionId: '11', answer: 'Фақат назарий билимларни ошириш', isCorrect: false),
        AnswerModel(id: '4', questionId: '11', answer: 'Амалий машқларни етишмаслик', isCorrect: false),
      ],
    ),
    QuestionModel(
      id: '12',
      testId: '1',
      question: 'Муаммо ҳал этиш жараёнида муҳим бўлган кўникма қандай?',
      answers: [
        AnswerModel(id: '1', questionId: '12', answer: 'Ижодий фикрлаш ва ҳал қилиш', isCorrect: true),
        AnswerModel(id: '2', questionId: '12', answer: 'Фақат илмий таҳлил', isCorrect: false),
        AnswerModel(id: '3', questionId: '12', answer: 'Муаммоларни шошилинч ҳал қилиш', isCorrect: false),
        AnswerModel(id: '4', questionId: '12', answer: 'Фақат шахсий тажриба', isCorrect: false),
      ],
    ),
    QuestionModel(
      id: '13',
      testId: '1',
      question: 'Академик ёзувда қандай тил асосий ҳисобланади?',
      answers: [
        AnswerModel(id: '1', questionId: '13', answer: 'Самарали ва аниқ тил', isCorrect: true),
        AnswerModel(id: '2', questionId: '13', answer: 'Ҳиссий ва таъсирчан тил', isCorrect: false),
        AnswerModel(id: '3', questionId: '13', answer: 'Оддий тил', isCorrect: false),
        AnswerModel(id: '4', questionId: '13', answer: 'Кавишланган тил', isCorrect: false),
      ],
    ),
    QuestionModel(
      id: '14',
      testId: '1',
      question: 'Академик тадқиқотда қайси усуллар қўлланилади?',
      answers: [
        AnswerModel(id: '1', questionId: '14', answer: 'Квалитатив ва квантитатив методлар', isCorrect: true),
        AnswerModel(id: '2', questionId: '14', answer: 'Фақат тадқиқотлар', isCorrect: false),
        AnswerModel(id: '3', questionId: '14', answer: 'Психологик тестлар', isCorrect: false),
        AnswerModel(id: '4', questionId: '14', answer: 'Теориялар ва моделлар', isCorrect: false),
      ],
    ),
    QuestionModel(
      id: '15',
      testId: '1',
      question: 'Академик ёзувнинг асосий мақсади нимада?',
      answers: [
        AnswerModel(id: '1', questionId: '15', answer: 'Илмий ифодаларни тушунарли баён этиш', isCorrect: true),
        AnswerModel(id: '2', questionId: '15', answer: 'Маълумотларни текин ва тез тарқатиш', isCorrect: false),
        AnswerModel(id: '3', questionId: '15', answer: 'Илмий тадқиқотларда натижаларни тасдиқлаш', isCorrect: false),
        AnswerModel(id: '4', questionId: '15', answer: 'Сиёсий йўналишда маълумот бериш', isCorrect: false),
      ],
    ),
    QuestionModel(
      id: '16',
      testId: '1',
      question: 'Касбий компетентликнинг ривожланишида қайси омил муҳим?',
      answers: [
        AnswerModel(id: '1', questionId: '16', answer: 'Ижтимоий алоқалар ва тажриба', isCorrect: true),
        AnswerModel(id: '2', questionId: '16', answer: 'Янгиликка қаратилган мурожаатлар', isCorrect: false),
        AnswerModel(id: '3', questionId: '16', answer: 'Мутлақ билишга интилиш', isCorrect: false),
        AnswerModel(id: '4', questionId: '16', answer: 'Ҳар доим янгиланган китоблар', isCorrect: false),
      ],
    ),
    QuestionModel(
      id: '17',
      testId: '1',
      question: 'Академик ёзувда манбааларни ишлатишда қандай қоидалар мавжуд?',
      answers: [
        AnswerModel(id: '1', questionId: '17', answer: 'Манбааларнинг аниқ ва тўлиқ кўрсатилиши', isCorrect: true),
        AnswerModel(id: '2', questionId: '17', answer: 'Фақат бир манбаа ишлатиш', isCorrect: false),
        AnswerModel(id: '3', questionId: '17', answer: 'Манбааларни изоҳсиз ишлатиш', isCorrect: false),
        AnswerModel(id: '4', questionId: '17', answer: 'Қайта-қайта бир манбаани ишлатиш', isCorrect: false),
      ],
    ),
    QuestionModel(
      id: '18',
      testId: '1',
      question: 'Профессионал этикада ишлашда қандай принципларга амал қилинади?',
      answers: [
        AnswerModel(id: '1', questionId: '18', answer: 'Самарадорлик, ахлоқ ва масъулият', isCorrect: true),
        AnswerModel(id: '2', questionId: '18', answer: 'Бешик ёзиш', isCorrect: false),
        AnswerModel(id: '3', questionId: '18', answer: 'Манбаани турли хиллаштириш', isCorrect: false),
        AnswerModel(id: '4', questionId: '18', answer: 'Ҳар қандай ишни тез ҳал қилиш', isCorrect: false),
      ],
    ),
    QuestionModel(
      id: '19',
      testId: '1',
      question: 'Академик ёзувда қайси хатоларни амалга ошириш мумкин эмас?',
      answers: [
        AnswerModel(id: '1', questionId: '19', answer: 'Плагиятдан фойдаланиш', isCorrect: true),
        AnswerModel(id: '2', questionId: '19', answer: 'Кўп манбаалардан фойдаланиш', isCorrect: false),
        AnswerModel(id: '3', questionId: '19', answer: 'Илмий ишларнинг аниқлигини таъминлаш', isCorrect: false),
        AnswerModel(id: '4', questionId: '19', answer: 'Ҳар хил манбааларни тақдим этиш', isCorrect: false),
      ],
    ),
    QuestionModel(
      id: '20',
      testId: '1',
      question: 'Профессионал коммуникациянинг қандай шакллари мавжуд?',
      answers: [
        AnswerModel(id: '1', questionId: '20', answer: 'Вербаль, визуал ва рақамли', isCorrect: true),
        AnswerModel(id: '2', questionId: '20', answer: 'Фақат рақамли ва визуал', isCorrect: false),
        AnswerModel(id: '3', questionId: '20', answer: 'Вербаль ва ижтимоий', isCorrect: false),
        AnswerModel(id: '4', questionId: '20', answer: 'Вербаль, рангли ва ижтимоий', isCorrect: false),
      ],
    ),
    QuestionModel(
      id: '21',
      testId: '1',
      question: 'Критик фикрлашнинг асосий элементлари қандай?',
      answers: [
        AnswerModel(id: '1', questionId: '21', answer: 'Маълумотларни таҳлил қилиш ва баҳолаш', isCorrect: true),
        AnswerModel(id: '2', questionId: '21', answer: 'Тахмин ва гипотеза қуриш', isCorrect: false),
        AnswerModel(id: '3', questionId: '21', answer: 'Одамларнинг ҳис-туйғуларини тушуниш', isCorrect: false),
        AnswerModel(id: '4', questionId: '21', answer: 'Бошқаларнинг фикрларини баҳолаш', isCorrect: false),
      ],
    ),
    QuestionModel(
      id: '22',
      testId: '1',
      question: 'Касбий компетентликни қандай тушуниш мумкин?',
      answers: [
        AnswerModel(id: '1', questionId: '22', answer: 'Касбий билимлар, кўникмалар ва иш тажрибаси', isCorrect: true),
        AnswerModel(id: '2', questionId: '22', answer: 'Ҳар қандай ишни бажариш қобилияти', isCorrect: false),
        AnswerModel(id: '3', questionId: '22', answer: 'Техник қобилиятлар', isCorrect: false),
        AnswerModel(id: '4', questionId: '22', answer: 'Фақат ишлаб чиқариш жараёнидаги маҳорат', isCorrect: false),
      ],
    ),
    QuestionModel(
      id: '23',
      testId: '1',
      question: 'Профессионал компетентликни ривожлантириш учун қандай йўллар мавжуд?',
      answers: [
        AnswerModel(
          id: '1',
          questionId: '23',
          answer: 'Таълим ва амалий машқлар орқали тажриба орттириш',
          isCorrect: true,
        ),
        AnswerModel(id: '2', questionId: '23', answer: 'Янгиланган китобларни ўқиш', isCorrect: false),
        AnswerModel(id: '3', questionId: '23', answer: 'Янгиланган китобларни ўқиш', isCorrect: false),
        AnswerModel(id: '4', questionId: '23', answer: 'Мутахассислар билан суҳбатлашиш', isCorrect: false),
      ],
    ),
    QuestionModel(
      id: '24',
      testId: '1',
      question: 'Касбий компетентликнинг қандай компонентлари мавжуд?',
      answers: [
        AnswerModel(id: '1', questionId: '24', answer: 'Билимлар, кўникмалар ва иш тажрибаси', isCorrect: true),
        AnswerModel(id: '2', questionId: '24', answer: 'Шахсий малакалар, жамоа билан ишлаш', isCorrect: false),
        AnswerModel(id: '3', questionId: '24', answer: 'Техник ёрдамлар ва қурилмалар', isCorrect: false),
        AnswerModel(id: '4', questionId: '24', answer: 'Ташкилий кўникмалар', isCorrect: false),
      ],
    ),
    QuestionModel(
      id: '25',
      testId: '1',
      question: '“Профессионал этика” тушунчаси нима?',
      answers: [
        AnswerModel(
          id: '1',
          questionId: '25',
          answer: 'Иш жараёнида ахлоқий нормаларни ва стандартларни бажариш',
          isCorrect: true,
        ),
        AnswerModel(id: '2', questionId: '25', answer: 'Меҳнат ҳуқуқлари', isCorrect: false),
        AnswerModel(id: '3', questionId: '25', answer: 'Ишда қатъий бўлиш', isCorrect: false),
        AnswerModel(id: '4', questionId: '25', answer: 'Тўғри маълумот бериш', isCorrect: false),
      ],
    ),
    QuestionModel(
      id: '26',
      testId: '1',
      question: 'Профессионал коммуникацияда ишончни қандай шакллантириш мумкин?',
      answers: [
        AnswerModel(id: '1', questionId: '26', answer: 'Тўғри ва самарали ишлаш', isCorrect: true),
        AnswerModel(id: '2', questionId: '26', answer: 'Кўп муаммоларни ҳал қилиш', isCorrect: false),
        AnswerModel(
          id: '3',
          questionId: '26',
          answer: 'Бошқа одамларни хато қилишига ишонч билдириш',
          isCorrect: false,
        ),
        AnswerModel(
          id: '4',
          questionId: '26',
          answer: 'Бошқа инсонлар билан мулоқотда ошкоралик ва рўйхатдан ўтказиш',
          isCorrect: false,
        ),
      ],
    ),
    QuestionModel(
      id: '27',
      testId: '1',
      question: '“Компетентлик” тушунчаси қандай?',
      answers: [
        AnswerModel(
          id: '1',
          questionId: '27',
          answer: 'Касбий вазифани бажариш учун зарур бўлган билимлар ва кўникмалар',
          isCorrect: true,
        ),
        AnswerModel(id: '2', questionId: '27', answer: 'Билимларнинг тўпланиши', isCorrect: false),
        AnswerModel(id: '3', questionId: '27', answer: 'Шахсий тажриба', isCorrect: false),
        AnswerModel(id: '4', questionId: '27', answer: 'Ҳар қандай касбда ишлаш қобилияти', isCorrect: false),
      ],
    ),
    QuestionModel(
      id: '28',
      testId: '1',
      question: 'Касбий компетентликнинг қандай элементлари бор?',
      answers: [
        AnswerModel(
          id: '1',
          questionId: '28',
          answer: 'Билим, кўникмалар, ижтимоий ва шахсий қобилиятлар',
          isCorrect: true,
        ),
        AnswerModel(id: '2', questionId: '28', answer: 'Ҳар қандай касбий хизматлар', isCorrect: false),
        AnswerModel(id: '3', questionId: '28', answer: 'Ташкилий ва мантиқий қобилиятлар', isCorrect: false),
        AnswerModel(id: '4', questionId: '28', answer: 'Техник ва амалий кўникмалар', isCorrect: false),
      ],
    ),
    QuestionModel(
      id: '29',
      testId: '1',
      question: 'Профессионал ахлоқни қандай қоидалар белгилайди?',
      answers: [
        AnswerModel(id: '1', questionId: '29', answer: 'Касбий стандартлар ва этика кодекси', isCorrect: true),
        AnswerModel(id: '2', questionId: '29', answer: 'Ҳар қандай касбга оид кўрсатмалар', isCorrect: false),
        AnswerModel(id: '3', questionId: '29', answer: 'Фақат ҳуқуқий қоидалар', isCorrect: false),
        AnswerModel(id: '4', questionId: '29', answer: 'Фақат иш жойидаги ахлоқий қарорлар', isCorrect: false),
      ],
    ),
    QuestionModel(
      id: '30',
      testId: '1',
      question: 'Академик ахлоқнинг асосий талаблари қуйидагилардан қайси бири?',
      answers: [
        AnswerModel(id: '1', questionId: '30', answer: 'Плагият ва манбаа нишонларини ҳисобга олиш', isCorrect: true),
        AnswerModel(id: '2', questionId: '30', answer: 'Ҳар қандай манбаани ижобий ёзиш', isCorrect: false),
        AnswerModel(
          id: '3',
          questionId: '30',
          answer: 'Илмий тадқиқотларда ўз фикрингизни шакллантириш',
          isCorrect: false,
        ),
        AnswerModel(
          id: '4',
          questionId: '30',
          answer: 'Фақат бир ойлик назарий тадқиқотларни амалга ошириш',
          isCorrect: false,
        ),
      ],
    ),
  ];
}
