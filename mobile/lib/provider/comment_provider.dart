import 'dart:async';
import 'dart:io';
import 'package:client/common/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../common/api.dart';
import '../model/comment/comment_model.dart';
import '../model/comment/comment_response_data.dart';
import '../repository/comment_repository.dart';
import '../storage/storage.dart';

final commentProvider = Provider((ref) => CommentProvider());

class CommentProvider {
  final repository = CommentRepository();

  Future<int> postComment(String comment, String blogId) async {
    try {
      final id = await StorageProvider().getUserId();
      final model =
          CommentModel(comment: comment, blogId: blogId, createdBy: id!);
      return await repository.postComment(model);
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

  Future<List<CommentResponseData>> getCommentByBlogId(String id) async {
    try {
      final response = await repository.getCommentByBlogId(id);

      return response.data;
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

  Future<void> likeComment(String commmentId) async {
    try {
      await repository.likeComment(commmentId);
    } on SocketException catch (_) {
      showSnackBar(noConnection);
      rethrow;
    } catch (_) {
      showSnackBar(somethingWentWrong);
      rethrow;
    }
  }

  Future<void> deleteComment(String commentId) async {
    try {
      final response = await repository.deleteComment(commentId);
      if (response.status == 200) {
        showSnackBar(response.message);
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
}
