class LoginModel {
  final String email;
  final String password;
  LoginModel({
    required this.password,
    required this.email,
  });

  Map<String, dynamic> toMap() => {
        'email': email,
        'password': password,
      };
}

class LoginResponseModel {
  LoginResponseModel({
    required this.status,
    required this.message,
    required this.data,
    required this.token,
  });

  final int? status;
  final String? message;
  final Data? data;
  final String? token;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      status: json["status"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
      token: json["token"],
    );
  }
}

class Data {
  Data({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json["_id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }
}
