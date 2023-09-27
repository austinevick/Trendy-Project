import 'dart:convert';

import 'package:client/model/reply/reply_model.dart';
import 'package:http/http.dart';

import '../common/api.dart';
import '../storage/storage.dart';

class ReplyRepository {
  final _client = Client();

  Future<int> replyToComment(ReplyModel model) async {
    final token = await StorageProvider().getToken();
    final response = await _client.post(Uri.parse("${baseUrl}reply"),
        body: model.toMap(),
        headers: {"Authorization": token!}).timeout(timeLimit);
    final data = jsonDecode(response.body);
    return ReplyResponseModel.fromJsonNoData(data).status;
  }

  Future<ReplyResponseModel> getRepliesByCommentId(String id) async {
    final token = await StorageProvider().getToken();
    final response = await _client.get(Uri.parse("${baseUrl}reply/comment/$id"),
        headers: {"Authorization": token!}).timeout(timeLimit);
    final data = jsonDecode(response.body);
    return ReplyResponseModel.fromJson(data);
  }

  // Future<CommentResponseModel> likeComment(String commentId) async {
  //   final token = await StorageProvider().getToken();
  //   final userId = await StorageProvider().getUserId();
  //   final response = await _client.put(
  //       Uri.parse("${baseUrl}comment/likes/$userId"),
  //       body: {"commentId": commentId},
  //       headers: {"Authorization": token!}).timeout(timeLimit);
  //   final data = jsonDecode(response.body);
  //   print(data);
  //   return CommentResponseModel.fromJsonNoData(data);
  // }
}
