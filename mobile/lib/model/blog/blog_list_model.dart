import 'blog_response_data.dart';

class BlogListResponseModel {
  final int status;
  final String message;
  final List<BlogResponseData> data;

  BlogListResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BlogListResponseModel.fromJson(Map<String, dynamic> json) =>
      BlogListResponseModel(
        status: json["status"],
        message: json["message"],
        data: List<BlogResponseData>.from(
            json["data"].map((x) => BlogResponseData.fromJson(x))),
      );
}
