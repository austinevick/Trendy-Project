class UserResponseModel {
  UserResponseModel({
    required this.status,
    required this.message,
    this.data,
  });

  final int? status;
  final String? message;
  final UserResponseData? data;

  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
      status: json["status"],
      message: json["message"],
      data:
          json["data"] == null ? null : UserResponseData.fromJson(json["data"]),
    );
  }
  factory UserResponseModel.fromJsonNoData(Map<String, dynamic> json) {
    return UserResponseModel(status: json["status"], message: json["message"]);
  }
}

class UserResponseData {
  UserResponseData({
    required this.following,
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
  });

  final List<dynamic> following;
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? about;
  final List<dynamic> followers;
  final String imageUrl;
  final String? profession;

  factory UserResponseData.fromJson(Map<String, dynamic> json) {
    return UserResponseData(
      following: json["following"] == null
          ? []
          : List<dynamic>.from(json["following"]!.map((x) => x)),
      id: json["_id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      about: json["about"],
      followers: json["followers"] == null
          ? []
          : List<dynamic>.from(json["followers"]!.map((x) => x)),
      imageUrl: json["imageUrl"] ?? '',
      profession: json["profession"],
    );
  }
}
