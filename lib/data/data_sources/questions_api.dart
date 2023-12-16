import 'package:http/http.dart' as http;
import 'package:komodo_trivia/core/constants/strings.dart';

class QuestionsApi {
  final http.Client client;

  QuestionsApi({http.Client? client}) : client = client ?? http.Client();

  Future<http.Response> getQuestions(
      {required int category,
      required int amount,
      required String difficulty,
      required bool isBool}) async {
    try {
      http.Response res = await client.get(Uri.parse(isBool
          ? '$kQuestionsUri?amount=$amount&category=$category&difficulty=${difficulty.toLowerCase()}&type=boolean'
          : '$kQuestionsUri?amount=$amount&category=$category&difficulty=${difficulty.toLowerCase()}&type=multiple'));
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
