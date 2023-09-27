import '../reply/reply_model.dart';

class CommentResponseData {
  final String id;
  final String comment;
  final String blogId;
  final List<dynamic> likes;
  final List<ReplyResponseData> replies;
  final CreatedBy createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  CommentResponseData({
    required this.id,
    required this.comment,
    required this.blogId,
    required this.likes,
    required this.replies,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory CommentResponseData.fromJson(Map<String, dynamic> json) =>
      CommentResponseData(
        id: json["_id"],
        comment: json["comment"] ?? '',
        blogId: json["blog_id"],
        likes: List<dynamic>.from(json["likes"].map((x) => x)),
        replies: List<ReplyResponseData>.from(
            json["replies"].map((x) => ReplyResponseData.fromJson(x))),
        createdBy: CreatedBy.fromJson(json["created_by"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );
}

class CreatedBy {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final String about;
  final List<dynamic> followers;
  final String imageUrl;
  final String profession;
  final List<dynamic> following;

  CreatedBy({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.about,
    required this.followers,
    required this.imageUrl,
    required this.profession,
    required this.following,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json["_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        about: json["about"],
        followers: List<dynamic>.from(json["followers"].map((x) => x)),
        imageUrl: json["imageUrl"],
        profession: json["profession"],
        following: List<dynamic>.from(json["following"].map((x) => x)),
      );
}
