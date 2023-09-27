import 'dart:async';
import 'dart:io';

import 'package:client/common/utils.dart';
import 'package:client/repository/blog_repository.dart';
import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../cloudinary_keys.dart';
import '../../storage/storage.dart';
import '../common/api.dart';
import '../common/enum.dart';
import '../model/auth/user_post_model.dart';
import '../model/blog/blog_model.dart';
import '../model/blog/blog_response_data.dart';
import '../repository/auth_repository.dart';

final blogsFutureProvider =
    FutureProvider((ref) => ref.watch(blogProvider).fetchBlog());

final userBlogFutureProvider = FutureProvider.family(
    (ref, String id) => ref.watch(blogProvider).getUserPosts(id));

final blogFutureProvider = FutureProvider.family(
    (ref, String id) => ref.watch(blogProvider).fetchBlogById(id));

final blogProvider = ChangeNotifierProvider((ref) => BlogProvider(ref));

class BlogProvider extends ChangeNotifier {
  final Ref ref;
  BlogProvider(this.ref);

  double progress = 0;

  Future<List<BlogResponseData>> fetchBlog() async {
    try {
      final response = await ref.watch(blogRepository).fetchBlog();
      return response.data;
    } on SocketException catch (_) {
      rethrow;
    } catch (_) {
      rethrow;
    }
  }

  Future<BlogResponseData> fetchBlogById(String id) async {
    try {
      final response = await ref.watch(blogRepository).fetchBlogById(id);
      return response.data!;
    } on SocketException catch (_) {
      rethrow;
    } catch (_) {
      rethrow;
    }
  }

  Future<List<UserPostModelData>> getUserPosts(String id) async {
    try {
      final response = await AuthRepository.getUserPosts(id);
      return response.data;
    } on SocketException catch (_) {
      rethrow;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> likeBlog(String blogId) async {
    try {
      await ref.watch(blogRepository).likeBlog(blogId);
    } on SocketException catch (_) {
      showSnackBar(noConnection);
      rethrow;
    } catch (_) {
      showSnackBar(somethingWentWrong);
      rethrow;
    }
  }

  Future<void> deleteBlog(String blogId) async {
    try {
      final response = await ref.watch(blogRepository).deleteBlog(blogId);
      if (response.status == 200) {
        showSnackBar(response.message);
        ref.invalidate(blogsFutureProvider);
      }
    } on SocketException catch (_) {
      showSnackBar(noConnection);
      rethrow;
    } on TimeoutException catch (_) {
      showSnackBar(timeout);
      rethrow;
    } catch (_) {
      showSnackBar(somethingWentWrong);
      rethrow;
    }
  }

  Future<void> createBlogWithText(String content) async {
    try {
      final userId = await StorageProvider().getUserId();
      final model = BlogModel(
          content: content,
          author: userId!,
          mediaUrl: '',
          mediaType: MediaType.none);
      final response = await ref.watch(blogRepository).createBlog(model);
      if (response.status == 201) {
        showSnackBar('Your post has been uploaded successfully');
        ref.invalidate(blogsFutureProvider);
      }
    } on SocketException catch (_) {
      showSnackBar(noConnection);
      rethrow;
    } on TimeoutException catch (_) {
      showSnackBar(timeout);
      rethrow;
    } catch (e) {
      showSnackBar(e.toString());
      rethrow;
    }
  }

  Future<void> createBlogWithImage(String content, File image) async {
    try {
      final userId = await StorageProvider().getUserId();
      final imageUrl =
          await uploadFileToCloudinary(image, CloudinaryResourceType.image);
      final model = BlogModel(
          content: content,
          mediaUrl: imageUrl!,
          mediaType: MediaType.image,
          author: userId!);
      final response = await ref.watch(blogRepository).createBlog(model);
      if (response.status == 201) {
        showSnackBar('Your post has been uploaded successfully');
        ref.invalidate(blogsFutureProvider);
      }
      showSnackBar(response.message);
    } on SocketException catch (_) {
      showSnackBar(noConnection);
      rethrow;
    } on TimeoutException catch (_) {
      showSnackBar(timeout);
      rethrow;
    } catch (e) {
      showSnackBar(e.toString());
      rethrow;
    }
  }

  Future<void> createBlogWithVideo(String content, File video) async {
    try {
      final userId = await StorageProvider().getUserId();
      final videoUrl =
          await uploadFileToCloudinary(video, CloudinaryResourceType.video);
      final model = BlogModel(
          content: content,
          mediaUrl: videoUrl!,
          author: userId!,
          mediaType: MediaType.video);
      final response = await ref.watch(blogRepository).createBlog(model);
      if (response.status == 201) {
        showSnackBar('Your post has been uploaded successfully');
        ref.invalidate(blogsFutureProvider);
      }
      showSnackBar(response.message);
    } on SocketException catch (_) {
      showSnackBar(noConnection);
      rethrow;
    } on TimeoutException catch (_) {
      showSnackBar(timeout);
      rethrow;
    } catch (e) {
      showSnackBar(e.toString());
      rethrow;
    }
  }

  Future<String?> uploadFileToCloudinary(
      File file, CloudinaryResourceType resourceType) async {
    try {
      final cloudinary = Cloudinary.signedConfig(
          apiKey: CLOUDINARY_APIKEY,
          apiSecret: CLOUDINARY_APISECRET,
          cloudName: CLOUDINARY_CLOUNDNAME);
      final url = await cloudinary.upload(
        file: file.path,
        resourceType: resourceType,
        fileBytes: File(file.path).readAsBytesSync(),
      );
      return url.url;
    } catch (e) {
      rethrow;
    }
  }

  String setBlogCommentsText(BlogResponseData data) {
    return '${data.comments.isEmpty ? '' : "${data.comments.length} comments"} ${data.repost.isEmpty ? '' : "• ${data.repost.length} reposts"}';
  }

  String setBlogListCommentsText(BlogResponseData data) {
    return '${data.comments.isEmpty ? '' : "${data.comments.length} comments"} ${data.repost.isEmpty ? '' : "• ${data.repost.length} reposts"}';
  }
}
