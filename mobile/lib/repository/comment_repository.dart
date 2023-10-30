import 'dart:convert';

import 'package:client/model/comment/comment_model.dart';
import 'package:http/http.dart';

import '../common/api.dart';
import '../model/comment/comments_list_response.dart';
import '../storage/storage.dart';

class CommentRepository {
  final _client = Client();

  Future<int> postComment(CommentModel model) async {
    final token = await StorageProvider().getToken();
    final response = await _client.post(Uri.parse("${baseUrl}comment"),
        body: model.toJson(),
        headers: {"Authorization": token!}).timeout(timeLimit);
    final data = jsonDecode(response.body);
    print(data);
    return CommentResponseModel.fromJsonNoData(data).status;
  }

  Future<CommentsResponseModel> getCommentByBlogId(String id) async {
    final token = await StorageProvider().getToken();
    final response = await _client.get(Uri.parse("${baseUrl}comment/blog/$id"),
        headers: {"Authorization": token!}).timeout(timeLimit);
    final data = jsonDecode(response.body);
    return CommentsResponseModel.fromJson(data);
  }

  Future<CommentResponseModel> likeComment(String commentId) async {
    final token = await StorageProvider().getToken();
    final userId = await StorageProvider().getUserId();
    final response = await _client.put(
        Uri.parse("${baseUrl}comment/likes/$userId"),
        body: {"commentId": commentId},
        headers: {"Authorization": token!}).timeout(timeLimit);
    final data = jsonDecode(response.body);
    print(data);
    return CommentResponseModel.fromJsonNoData(data);
  }

  Future<CommentResponseModel> deleteComment(String commentId) async {
    final token = await StorageProvider().getToken();
    final response = await _client.delete(
      Uri.parse("${baseUrl}comment/$commentId"),
      headers: {"Authorization": token!},
    ).timeout(timeLimit);
    final data = jsonDecode(response.body);
    return CommentResponseModel.fromJsonNoData(data);
  }
}
