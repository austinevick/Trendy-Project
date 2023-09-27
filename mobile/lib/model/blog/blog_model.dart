import '../../common/enum.dart';
import 'blog_response_data.dart';

class BlogModel {
  BlogModel({
    required this.author,
    required this.mediaUrl,
    required this.mediaType,
    required this.content,
  });

  final String content;
  final String author;
  final String mediaUrl;
  final MediaType mediaType;

  Map<String, dynamic> toJson() => {
        "content": content,
        "author": author,
        "mediaUrl": mediaUrl,
        'mediaType': mediaType.type
      };
}

class BlogResponseModel {
  final int status;
  final String message;
  final BlogResponseData? data;

  BlogResponseModel({
    required this.status,
    required this.message,
    this.data,
  });

  factory BlogResponseModel.fromJson(Map<String, dynamic> json) =>
      BlogResponseModel(
        status: json["status"],
        message: json["message"],
        data: BlogResponseData.fromJson(json["data"]),
      );

  factory BlogResponseModel.fromJsonNoData(Map<String, dynamic> json) =>
      BlogResponseModel(
        status: json["status"],
        message: json["message"],
      );
}
