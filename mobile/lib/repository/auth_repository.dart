import 'dart:convert';
import 'package:http/http.dart';

import '../common/api.dart';
import '../model/auth/login_model.dart';
import '../model/auth/register_model.dart';
import '../model/auth/user_model.dart';
import '../model/auth/user_post_model.dart';
import '../storage/storage.dart';

class AuthRepository {
  static final _client = Client();

  static Future<LoginResponseModel> login(LoginModel model) async {
    final response = await _client.post(Uri.parse("${baseUrl}user/login"),
        body: model.toMap());
    final data = jsonDecode(response.body);
    print(data);

    return LoginResponseModel.fromJson(data);
  }

  static Future<RegisterResponseModel> register(RegisterModel model) async {
    final response = await _client.post(Uri.parse("${baseUrl}user/register"),
        body: model.toJson());
    final data = jsonDecode(response.body);
    print(data);
    return RegisterResponseModel.fromJson(data);
  }

  static Future<UserResponseModel> getUserData(String id) async {
    final token = await StorageProvider().getToken();
    final response = await _client.get(Uri.parse("${baseUrl}user/$id"),
        headers: {"Authorization": token!}).timeout(timeLimit);
    final data = jsonDecode(response.body);
    return UserResponseModel.fromJson(data);
  }

  static Future<UserPostModel> getUserPosts(String id) async {
    final token = await StorageProvider().getToken();
    final response = await _client.get(Uri.parse("${baseUrl}user/posts/$id"),
        headers: {"Authorization": token!}).timeout(timeLimit);
    final data = jsonDecode(response.body);
    return UserPostModel.fromJson(data);
  }

  static Future<UserResponseModel> updateUserData(RegisterModel model) async {
    final id = await StorageProvider().getUserId();
    final token = await StorageProvider().getToken();
    final response = await _client.put(Uri.parse("${baseUrl}user/$id"),
        body: model.updateData(),
        headers: {"Authorization": token!}).timeout(timeLimit);
    final data = jsonDecode(response.body);
    return UserResponseModel.fromJson(data);
  }

  static Future<UserResponseModel> updateProfilePicture(String imageUrl) async {
    final id = await StorageProvider().getUserId();
    final token = await StorageProvider().getToken();
    final response = await _client.put(Uri.parse("${baseUrl}user/$id"),
        body: {"imageUrl": imageUrl},
        headers: {"Authorization": token!}).timeout(timeLimit);
    final data = jsonDecode(response.body);
    return UserResponseModel.fromJsonNoData(data);
  }
}
