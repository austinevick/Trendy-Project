import 'dart:io';

import 'package:client/common/utils.dart';
import 'package:client/repository/auth_repository.dart';
import 'package:client/storage/storage.dart';
import 'package:client/view/bottom_navigation_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../common/api.dart';
import '../model/auth/login_model.dart';
import '../model/auth/register_model.dart';

final authViewModel =
    StateNotifierProvider<AuthViewProvider, bool>((ref) => AuthViewProvider());

class AuthViewProvider extends StateNotifier<bool> {
  AuthViewProvider() : super(false);

  Future<void> login(LoginModel model) async {
    try {
      state = true;
      final response = await AuthRepository.login(model);
      if (response.status == 200) {
        StorageProvider().saveToken(response.token!);
        StorageProvider().saveUserId(response.data!.id!);
        pushAndRemoveUntil(const BottomNavigationScreen());
      }
      if (response.status == 400) {
        showSnackBar(response.message!);
        state = false;
      }
    } on SocketException catch (e) {
      state = false;
      showSnackBar(e.message);
      rethrow;
    } catch (e) {
      state = false;
      showSnackBar(somethingWentWrong);
      rethrow;
    }
  }

  Future<void> register(RegisterModel model) async {
    try {
      state = true;
      final response = await AuthRepository.register(model);
      if (response.status == 201) {
        StorageProvider().saveToken(response.token!);
        StorageProvider().saveUserId(response.data!.id!);
        pushAndRemoveUntil(const BottomNavigationScreen());
      }
      if (response.status == 400) {
        showSnackBar(response.message!);
        state = false;
      }
    } on SocketException catch (e) {
      state = false;
      showSnackBar(e.message);
      rethrow;
    } catch (_) {
      state = false;
      showSnackBar(somethingWentWrong);
      rethrow;
    }
  }
}
