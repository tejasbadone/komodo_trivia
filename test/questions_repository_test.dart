import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:komodo_trivia/core/constants/strings.dart';
import 'package:komodo_trivia/data/data_sources/questions_api.dart';
import 'package:komodo_trivia/data/models/question_model.dart';
import 'package:komodo_trivia/data/repositories/questions_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements Client {}

void main() {
  late QuestionsRepository questionsRepository;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    questionsRepository =
        QuestionsRepository(questionsApi: QuestionsApi(client: mockClient));
  });

  group('Questions Repository ->', () {
    test(
        'given QuestionsRepository when getQuestions method called and status code is 200 then a List<Question> should be returned',
        () async {
      when(() => mockClient.get(Uri.parse(
              '$kQuestionsUri?amount=10&category=28&difficulty=easy&type=multiple')))
          .thenAnswer((invocation) async => Response('''{
    "response_code": 0,
    "results": [
        {
            "type": "multiple",
            "difficulty": "easy",
            "category": "Vehicles",
            "question": "Which car tire manufacturer is famous for its &quot;P Zero&quot; line?",
            "correct_answer": "Pirelli",
            "incorrect_answers": [
                "Goodyear",
                "Bridgestone",
                "Michelin"
            ]
        },
        {
            "type": "multiple",
            "difficulty": "easy",
            "category": "Vehicles",
            "question": "Jaguar Cars was previously owned by which car manfacturer?",
            "correct_answer": "Ford",
            "incorrect_answers": [
                "Chrysler",
                "General Motors",
                "Fiat"
            ]
        },
        {
            "type": "multiple",
            "difficulty": "easy",
            "category": "Vehicles",
            "question": "The LS2 engine is how many cubic inches?",
            "correct_answer": "364",
            "incorrect_answers": [
                "346",
                "376",
                "402"
            ]
        },
        {
            "type": "multiple",
            "difficulty": "easy",
            "category": "Vehicles",
            "question": "The LS7 engine is how many cubic inches?",
            "correct_answer": "427",
            "incorrect_answers": [
                "346",
                "364",
                "376"
            ]
        },
        {
            "type": "multiple",
            "difficulty": "easy",
            "category": "Vehicles",
            "question": "The Italian automaker Lamborghini uses what animal as its logo?",
            "correct_answer": "Bull",
            "incorrect_answers": [
                "Bat",
                "Horse",
                "Snake"
            ]
        },
        
        {
            "type": "multiple",
            "difficulty": "easy",
            "category": "Vehicles",
            "question": "What country was the Trabant 601 manufactured in?",
            "correct_answer": "East Germany",
            "incorrect_answers": [
                "Soviet Union",
                "Hungary",
                "France"
            ]
        }
    ]
}''', 200));

      final result = await questionsRepository.getQuestions(
          category: 28, amount: 10, difficulty: 'easy', isBool: false);

      expect(result, isA<List<Question>>());
    });
  });
}
