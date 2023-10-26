import 'dart:io';
import 'package:client/common/api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../cloudinary_keys.dart';
import 'package:cloudinary/cloudinary.dart';

import '../../common/utils.dart';
import '../../repository/auth_repository.dart';
import '../model/auth/register_model.dart';
import '../model/auth/user_model.dart';

final userDataProvider =
    FutureProvider((ref) => ref.watch(userProfileProvider).getUserData());

final userProfileProvider = Provider((ref) => UserProfileProvider(ref));

class UserProfileProvider {
  final Ref ref;

  UserProfileProvider(this.ref);

  Future<UserResponseData> getUserData() async {
    try {
      final response = await AuthRepository.getUserData();
      return response.data!;
    } on SocketException catch (_) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUserData(
      {required String imageUrl,
      required String firstName,
      required String lastName,
      required String email,
      required String profession,
      required String about}) async {
    try {
      loadingDialog();
      final model = RegisterModel(
        firstName: firstName,
        lastName: lastName,
        email: email,
        profession: profession,
        imageUrl: imageUrl,
        about: about,
      );
      final response = await AuthRepository.updateUserData(model);
      if (response.status == 200) {
        showSnackBar(response.message!);
        ref.invalidate(userDataProvider);
        pop();
      }
      pop();
    } on SocketException catch (_) {
      pop();
      showErrorDialog(noConnection);
      rethrow;
    } catch (_) {
      pop();
      showSnackBar(somethingWentWrong);
      rethrow;
    }
  }

  Future<String?> uploadImageToCloudinary(File image) async {
    try {
      final cloudinary = Cloudinary.signedConfig(
          apiKey: CLOUDINARY_APIKEY,
          apiSecret: CLOUDINARY_APISECRET,
          cloudName: CLOUDINARY_CLOUNDNAME);
      final imageurl = await cloudinary.upload(
        file: image.path,
        resourceType: CloudinaryResourceType.image,
        fileBytes: File(image.path).readAsBytesSync(),
      );
      return imageurl.url;
    } catch (e) {
      rethrow;
    }
  }
}
