


class LoginModel {
  LoginModel({
    this.user,
    this.token,
  });

  User? user;
  String? token;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    user: User.fromJson(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "token": token,
  };
}

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.has2Fa,
  });

  int? id;
  String? name;
  String? email;
  bool? has2Fa;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    has2Fa: json["has2FA"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "has2FA": has2Fa,
  };
}