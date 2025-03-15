class LoginModel {
  final int status;
  final String message;
  final User? user;

  LoginModel({required this.status, required this.message, this.user});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      status: json['status'] ?? 0, // Default value for status
      message: json['message'] ?? "No message", // Default value for message
      user: json['user'] != null
          ? User.fromJson(json['user'])
          : null, // User object can be null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      if (user != null)
        'user': user!.toJson(), // Only add 'user' if it's not null
    };
  }
}

class User {
  final int userId;
  final int societyId;
  final String societyName;
  final int flatId;
  final String flatNumber;
  final String block;
  final String role;
  final String uname;
  final String uemail;
  final String uphone;
  final String createdAt;

  User({
    required this.userId,
    required this.societyId,
    required this.societyName,
    required this.flatId,
    required this.flatNumber,
    required this.block,
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
      societyName: json['society_name'] ?? "Unknown",
      flatId: json['flat_id'] ?? 0,
      flatNumber: json['flat_number'] ?? "Unknown",
      block: json['block'] ?? "Unknown",
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
      'society_name': societyName,
      'flat_id': flatId,
      'flat_number': flatNumber,
      'block': block,
      'role': role,
      'uname': uname,
      'uemail': uemail,
      'uphone': uphone,
      'created_at': createdAt,
    };
  }
}
