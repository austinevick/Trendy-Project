import 'comment_response_data.dart';

class CommentsResponseModel {
  final int status;
  final String message;
  final List<CommentResponseData> data;

  CommentsResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CommentsResponseModel.fromJson(Map<String, dynamic> json) =>
      CommentsResponseModel(
        status: json["status"],
        message: json["message"],
        data: List<CommentResponseData>.from(
            json["data"].map((x) => CommentResponseData.fromJson(x))),
      );
}
