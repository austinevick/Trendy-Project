class UsersResponseModel {
  UsersResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final int? status;
  final String? message;
  final List<UsersData> data;

  factory UsersResponseModel.fromJson(Map<String, dynamic> json) {
    return UsersResponseModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<UsersData>.from(
              json["data"]!.map((x) => UsersData.fromJson(x))),
    );
  }
}

class UsersData {
  UsersData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profession,
    required this.imageUrl,
  });

  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? profession;
  final String? imageUrl;

  factory UsersData.fromJson(Map<String, dynamic> json) {
    return UsersData(
      id: json["_id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      profession: json["profession"],
      imageUrl: json["imageUrl"],
    );
  }
}
