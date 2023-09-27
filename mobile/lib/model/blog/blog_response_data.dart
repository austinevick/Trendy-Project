import 'package:client/common/enum.dart';

class BlogResponseData {
  final String id;
  final String content;
  final MediaType mediaType;
  final String mediaUrl;
  final List<String> hashtags;
  final Author author;
  final List<String> likes;
  final List<dynamic> repost;
  final List<Comment> comments;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  BlogResponseData({
    required this.id,
    required this.content,
    required this.mediaType,
    required this.mediaUrl,
    required this.hashtags,
    required this.author,
    required this.likes,
    required this.repost,
    required this.comments,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory BlogResponseData.fromJson(Map<String, dynamic> json) =>
      BlogResponseData(
        id: json["_id"],
        content: json["content"],
        mediaType: (json["mediaType"] as String).toEnum(),
        mediaUrl: json["mediaUrl"],
        hashtags: List<String>.from(json["hashtags"].map((x) => x)),
        author: Author.fromJson(json["author"]),
        likes: List<String>.from(json["likes"].map((x) => x)),
        repost: List<dynamic>.from(json["repost"].map((x) => x)),
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );
}

class Author {
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
  final String? password;

  Author({
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
    this.password,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["_id"],
        firstName: json["first_name"] ?? "",
        lastName: json["last_name"] ?? "",
        email: json["email"] ?? '',
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        about: json["about"] ?? '',
        followers: List<dynamic>.from(json["followers"].map((x) => x)),
        imageUrl: json["imageUrl"] ?? "",
        profession: json["profession"] ?? '',
        following: List<dynamic>.from(json["following"].map((x) => x)),
        password: json["password"],
      );
}

class Comment {
  final String id;
  final String comment;
  final String blogId;
  final List<dynamic> likes;
  final Author createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Comment({
    required this.id,
    required this.comment,
    required this.likes,
    required this.blogId,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["_id"],
        comment: json["comment"],
        blogId: json["blog_id"],
        likes: List<dynamic>.from(json["likes"].map((x) => x)),
        createdBy: Author.fromJson(json["created_by"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );
}
