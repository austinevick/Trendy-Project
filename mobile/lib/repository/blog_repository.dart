import 'dart:convert';
import 'package:http/http.dart';
import '../common/api.dart';
import '../model/blog/blog_list_model.dart';
import '../model/blog/blog_model.dart';
import '../storage/storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final blogRepository = Provider((ref) => BlogRepository());

class BlogRepository {
  final _client = Client();

  Future<BlogListResponseModel> fetchBlog() async {
    final token = await StorageProvider().getToken();
    final response = await _client.get(Uri.parse("${baseUrl}blog"),
        headers: {"Authorization": token!}).timeout(timeLimit);
    final data = jsonDecode(response.body);
    print(data['data']);
    return BlogListResponseModel.fromJson(data);
  }

  Future<BlogResponseModel> fetchBlogById(String id) async {
    final token = await StorageProvider().getToken();
    final response = await _client.get(Uri.parse("${baseUrl}blog/$id"),
        headers: {"Authorization": token!}).timeout(timeLimit);
    final data = jsonDecode(response.body);
    return BlogResponseModel.fromJson(data);
  }

  Future<BlogResponseModel> createBlog(BlogModel model) async {
    final token = await StorageProvider().getToken();
    final response = await _client
        .post(Uri.parse("${baseUrl}blog"),
            headers: {"Authorization": token!}, body: model.toJson())
        .timeout(timeLimit);
    final data = jsonDecode(response.body);
    return BlogResponseModel.fromJsonNoData(data);
  }

  Future<BlogResponseModel> deleteBlog(String blogId) async {
    final token = await StorageProvider().getToken();
    final response = await _client.delete(
      Uri.parse("${baseUrl}blog/$blogId"),
      headers: {"Authorization": token!},
    ).timeout(timeLimit);
    final data = jsonDecode(response.body);
    return BlogResponseModel.fromJsonNoData(data);
  }

  Future<void> likeBlog(String blogId) async {
    final token = await StorageProvider().getToken();
    final userId = await StorageProvider().getUserId();
    await _client.put(Uri.parse("${baseUrl}blog/likes/$userId"),
        headers: {"Authorization": token!},
        body: {'id': blogId}).timeout(timeLimit);
  }
}
