class RegisterModel {
  final String firstName;
  final String lastName;
  final String email;
  final String profession;
  final String imageUrl;
  final String about;
  final List? followers;
  final List? following;
  final String? password;
  RegisterModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profession,
    required this.imageUrl,
    required this.about,
    this.followers,
    this.following,
    this.password,
  });

  Map<String, dynamic> updateData() {
    return <String, dynamic>{
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'profession': profession,
      'imageUrl': imageUrl,
      'about': about
    };
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'profession': profession,
      'imageUrl': imageUrl,
      'about': about,
      'followers': followers!.map((x) => x).toList(),
      'following': following!.map((x) => x).toList(),
      'password': password,
    };
  }
}

class RegisterResponseModel {
  RegisterResponseModel({
    required this.status,
    required this.message,
    required this.data,
    required this.token,
  });

  final int? status;
  final String? message;
  final RegisterResponseData? data;
  final String? token;

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null
          ? null
          : RegisterResponseData.fromJson(json["data"]),
      token: json["token"],
    );
  }
}

class RegisterResponseData {
  RegisterResponseData({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory RegisterResponseData.fromJson(Map<String, dynamic> json) {
    return RegisterResponseData(
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      password: json["password"],
      id: json["_id"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }
}
