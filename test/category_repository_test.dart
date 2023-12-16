import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:komodo_trivia/core/constants/strings.dart';
import 'package:komodo_trivia/data/data_sources/category_api.dart';
import 'package:komodo_trivia/data/models/category_model.dart';
import 'package:komodo_trivia/data/repositories/category_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockClinet extends Mock implements Client {}

void main() {
  late CategoryRepository categoryRepository;
  late MockClinet mockClient;

  setUp(() {
    mockClient = MockClinet();
    categoryRepository =
        CategoryRepository(categoryApi: CategoryApi(client: mockClient));
  });

  group('category repository ->', () {
    test(
        'given CategoryRepository class when getCategories function is called and status code is 200 then a List of QuizCategory model should be returned',
        () async {
      when(() => mockClient.post(Uri.parse(kCategoryUri)))
          .thenAnswer((invocation) async => Response('''{
    "trivia_categories": [
        {
            "id": 9,
            "name": "General Knowledge"
        },
        {
            "id": 10,
            "name": "Entertainment: Books"
        },
        {
            "id": 11,
            "name": "Entertainment: Film"
        },
        {
            "id": 12,
            "name": "Entertainment: Music"
        },
        {
            "id": 13,
            "name": "Entertainment: Musicals & Theatres"
        },
        {
            "id": 14,
            "name": "Entertainment: Television"
        },
        {
            "id": 15,
            "name": "Entertainment: Video Games"
        },
        {
            "id": 16,
            "name": "Entertainment: Board Games"
        },
        {
            "id": 17,
            "name": "Science & Nature"
        }
        
    ]
}''', 200));

      final result = await categoryRepository.getCategories();

      expect(result, isA<List<QuizCategory>>());
    });
  });
}
