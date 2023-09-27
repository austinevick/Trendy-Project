import 'dart:async';
import 'dart:io';
import 'package:client/common/utils.dart';
import 'package:client/model/reply/reply_model.dart';
import 'package:client/repository/reply_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../common/api.dart';
import '../storage/storage.dart';

final replyProvider = Provider((ref) => ReplyProvider());

class ReplyProvider {
  final repository = ReplyRepository();

  Future<int> replyToComment(String reply, String commentId) async {
    try {
      final id = await StorageProvider().getUserId();
      final model = ReplyModel(reply, commentId, id!);
      return await repository.replyToComment(model);
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

  Future<List<ReplyResponseData>> getRepliesByCommentId(String id) async {
    try {
      final response = await repository.getRepliesByCommentId(id);

      return response.data!;
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

  // Future<void> likeComment(String commmentId) async {
  //   try {
  //     await repository.likeComment(commmentId);
  //   } on SocketException catch (_) {
  //     showSnackBar(noConnection);
  //     rethrow;
  //   } catch (_) {
  //     showSnackBar(somethingWentWrong);
  //     rethrow;
  //   }
  // }

  // Future<void> deleteComment(String commentId) async {
  //   try {
  //     final response = await repository.deleteComment(commentId);
  //     if (response.status == 200) {
  //       showSnackBar(response.message);
  //     }
  //   } on SocketException catch (_) {
  //     showSnackBar(noConnection);
  //     rethrow;
  //   } on TimeoutException catch (_) {
  //     showSnackBar(timeout);
  //     rethrow;
  //   } catch (_) {
  //     showSnackBar(somethingWentWrong);
  //     rethrow;
  //   }
  // }
}
