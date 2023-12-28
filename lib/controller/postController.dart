import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/postsModel.dart';
import '../services/httpGetRequest.dart';

final loadingDataController = StateProvider.autoDispose<bool>((ref) => true);

final postsProvider =
    StateNotifierProvider<GetPostController, List<PostsModel>?>((ref) {
    return GetPostController(httpGetPost: HttpGetPost());
});



class GetPostController extends StateNotifier<List<PostsModel>?> {
  HttpGetPost httpGetPost;
  GetPostController({required this.httpGetPost}) : super(null);

  Future<List<PostsModel>?> getPosts() async {
    try {
      var response = await httpGetPost.getPost();
      if (kDebugMode) {
        print("~~~~~~~~~~~~~~~Result~~~~~~~~~~~~~~~~~~~~");
        print("Result: ${response}");
      }
      state = response;
      return state;
    } catch (e) {
      print("error occured could not get the data due to $e");
    }
  }
}
