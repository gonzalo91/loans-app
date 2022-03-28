abstract class VerifyAuthServiceRepo {
  Future<AuthModel> verify();
}

class AuthModel {
  final Statuses status;
  final String message;

  AuthModel(this.status, this.message);
}

enum Statuses {
  noAuth,
  authExpired,
  authenticated,
}

class AuthUser {
  final int id;
  final String name;
  final String email;
  final String imageProfile;
  final double balance;

  AuthUser(this.id, this.name, this.email, this.imageProfile, this.balance);

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      json['id'] as int,
      json['name'] as String,
      json['email'] as String,
      json['image_profile'] as String,
      double.parse(json['balance'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "image_profile": imageProfile,
      "balance": balance,
    };
  }
}
