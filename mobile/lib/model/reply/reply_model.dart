class ReplyModel {
  final String reply;
  final String commentId;
  final String repliedBy;

  ReplyModel(this.reply, this.commentId, this.repliedBy);

  Map<String, dynamic> toMap() => {
        'reply': reply,
        'comment_id': commentId,
        'replied_by': repliedBy,
      };
}

class ReplyResponseModel {
  final int status;
  final String message;
  final List<ReplyResponseData>? data;

  ReplyResponseModel({required this.status, required this.message, this.data});

  factory ReplyResponseModel.fromJson(Map<String, dynamic> json) =>
      ReplyResponseModel(
        status: json["status"] ?? 0,
        message: json["message"] ?? '',
        data: List<ReplyResponseData>.from(
            json['data'].map((x) => ReplyResponseData.fromJson(x))),
      );
  factory ReplyResponseModel.fromJsonNoData(Map<String, dynamic> json) =>
      ReplyResponseModel(
        status: json["status"] ?? 0,
        message: json["message"] ?? '',
      );
}

class ReplyResponseData {
  final String id;
  final String reply;
  final String commentId;
  final List<dynamic> likes;
  final RepliedBy repliedBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  ReplyResponseData({
    required this.id,
    required this.reply,
    required this.commentId,
    required this.likes,
    required this.repliedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ReplyResponseData.fromJson(Map<String, dynamic> json) =>
      ReplyResponseData(
        id: json["_id"],
        reply: json["reply"],
        commentId: json["comment_id"],
        likes: List<dynamic>.from(json["likes"].map((x) => x)),
        repliedBy: RepliedBy.fromJson(json["replied_by"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );
}

class RepliedBy {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String about;
  final String profession;
  final String imageUrl;
  final List<dynamic> following;
  final List<dynamic> followers;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  RepliedBy({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.about,
    required this.profession,
    required this.imageUrl,
    required this.following,
    required this.followers,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory RepliedBy.fromJson(Map<String, dynamic> json) => RepliedBy(
        id: json["_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        about: json["about"],
        profession: json["profession"],
        imageUrl: json["imageUrl"],
        following: List<dynamic>.from(json["following"].map((x) => x)),
        followers: List<dynamic>.from(json["followers"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );
}
