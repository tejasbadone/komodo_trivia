import 'package:http/http.dart' as http;
import 'package:komodo_trivia/core/constants/strings.dart';

class CategoryApi {
  final http.Client client;

  CategoryApi({http.Client? client}) : client = client ?? http.Client();

  Future<http.Response> getCategories() async {
    try {
      http.Response res = await client.get(Uri.parse(kCategoryUri));

      return res;
    } catch (e) {
      rethrow;
    }
  }
}
