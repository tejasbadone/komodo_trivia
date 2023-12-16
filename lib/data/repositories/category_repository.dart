import 'dart:convert';
import 'dart:io';
import 'package:komodo_trivia/data/data_sources/category_api.dart';
import 'package:http/http.dart' as http;
import 'package:komodo_trivia/data/models/category_model.dart';

class CategoryRepository {
  final CategoryApi categoryApi;

  CategoryRepository({required this.categoryApi});

  Future<List<QuizCategory>> getCategories() async {
    try {
      List<QuizCategory> categoryList = [];

      http.Response res = await categoryApi.getCategories();

      if (res.statusCode == 200) {
        for (int i = 0;
            i < jsonDecode(res.body)['trivia_categories'].length;
            i++) {
          categoryList.add(
            QuizCategory.fromJson(
              jsonEncode(
                jsonDecode(res.body)['trivia_categories'][i],
              ),
            ),
          );
        }
        return categoryList;
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
