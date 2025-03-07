class LoginModel {
  final int status;
  final String message;
  final User? user;

  LoginModel({required this.status, required this.message, this.user});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      status: json['status'] ?? 0,
      message: json['message'] ?? "No message",
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      if (user != null) 'user': user!.toJson(),
    };
  }
}

class User {
  final int userId;
  final int societyId;
  final String role;
  final String uname;
  final String uemail;
  final String uphone;
  final String createdAt;

  User({
    required this.userId,
    required this.societyId,
    required this.role,
    required this.uname,
    required this.uemail,
    required this.uphone,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'] ?? 0,
      societyId: json['society_id'] ?? 0,
      role: json['role'] ?? "Unknown",
      uname: json['uname'] ?? "No Name",
      uemail: json['uemail'] ?? "No Email",
      uphone: json['uphone'] ?? "No Phone",
      createdAt: json['created_at'] ?? "N/A",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'society_id': societyId,
      'role': role,
      'uname': uname,
      'uemail': uemail,
      'uphone': uphone,
      'created_at': createdAt,
    };
  }
}
