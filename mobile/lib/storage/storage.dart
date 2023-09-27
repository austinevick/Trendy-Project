import 'package:client/common/utils.dart';
import 'package:client/view/auth/signin_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final storageProvider = Provider((ref) => StorageProvider());

class StorageProvider {
  String token = "token";
  String userId = "userId";

  Future<void> saveToken(String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(token, value);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(token);
  }

  Future<void> saveUserId(String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(userId, value);
  }

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userId);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(token);
    await prefs.remove(userId);
    pushAndRemoveUntil(const SigninView());
  }
}
