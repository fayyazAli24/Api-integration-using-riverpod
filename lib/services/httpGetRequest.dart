import 'package:http/http.dart' as http;

import '../model/postsModel.dart';

class HttpGetPost {
  static const String baseURL = "https://jsonplaceholder.typicode.com";
  static const String endPoint = "/posts";

  Future<List<PostsModel>> getPost() async {
    var response = await http.get(Uri.parse("$baseURL$endPoint"));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return postsModelFromJson(jsonString);
    } else {
      throw Exception("error data could not be fetched");
    }
  }
}
