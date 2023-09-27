import 'comment_response_data.dart';

class CommentModel {
  CommentModel({
    required this.comment,
    required this.blogId,
    required this.createdBy,
  });

  final String comment;
  final String blogId;
  final String createdBy;

  Map<String, dynamic> toJson() => {
        "comment": comment,
        "blog_id": blogId,
        "created_by": createdBy,
      };
}

class CommentResponseModel {
  final int status;
  final String message;
  final CommentResponseData? data;

  CommentResponseModel(
      {required this.status, required this.message, this.data});

  factory CommentResponseModel.fromJson(Map<String, dynamic> json) =>
      CommentResponseModel(
        status: json["status"] ?? 0,
        message: json["message"] ?? '',
        data: CommentResponseData.fromJson(json["data"]),
      );
  factory CommentResponseModel.fromJsonNoData(Map<String, dynamic> json) =>
      CommentResponseModel(
        status: json["status"] ?? 0,
        message: json["message"] ?? '',
      );
}
