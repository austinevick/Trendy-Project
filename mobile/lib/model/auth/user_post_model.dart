class UserPostModel {
  final int status;
  final String message;
  final List<UserPostModelData> data;

  UserPostModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UserPostModel.fromJson(Map<String, dynamic> json) => UserPostModel(
        status: json["status"],
        message: json["message"],
        data: List<UserPostModelData>.from(
            json["data"].map((x) => UserPostModelData.fromJson(x))),
      );
}

class UserPostModelData {
  final String id;
  final String content;
  final String mediaType;
  final String mediaUrl;

  UserPostModelData({
    required this.id,
    required this.content,
    required this.mediaType,
    required this.mediaUrl,
  });

  factory UserPostModelData.fromJson(Map<String, dynamic> json) =>
      UserPostModelData(
        id: json["_id"],
        content: json["content"],
        mediaType: json["mediaType"],
        mediaUrl: json["mediaUrl"],
      );
}
