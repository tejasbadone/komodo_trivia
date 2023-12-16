import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:komodo_trivia/data/data_sources/questions_api.dart';
import 'package:komodo_trivia/data/models/question_model.dart';

class QuestionsRepository {
  final QuestionsApi questionsApi;

  QuestionsRepository({required this.questionsApi});

  Future<List<Question>> getQuestions(
      {required int category,
      required int amount,
      required String difficulty,
      required bool isBool}) async {
    try {
      List<Question> questionsList = [];
      int resCode;

      http.Response res = await questionsApi.getQuestions(
          category: category,
          difficulty: difficulty,
          isBool: isBool,
          amount: amount);

      if (res.statusCode == 200) {
        resCode = jsonDecode(res.body)['response_code'];
        if (resCode == 0) {
          for (int i = 0; i < jsonDecode(res.body)['results'].length; i++) {
            questionsList.add(
              Question.fromJson(
                jsonEncode(
                  jsonDecode(res.body)['results'][i],
                ),
              ),
            );
          }
        } else {
          throw resCode;
        }

        return questionsList;
      } else {
        throw jsonDecode(res.body);
      }
    } catch (e) {
      if (e is SocketException) {
        throw 'socketerror';
      }
      rethrow;
    }
  }
}
