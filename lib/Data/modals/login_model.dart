class LoginModel {
  final int success;
  final DataModel? data;
  final String? error;

  LoginModel({required this.success, this.data, this.error});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      success: json["success"] ?? 0,
      data: json["data"] != null ? DataModel.fromJson(json["data"]) : null,
      error: json["error"],
    );
  }

  String? get access => data?.access;
  String? get refresh => data?.refresh;
  int? get userId => data?.userId;

  bool get isSuccess => success == 6000;
}

class DataModel {
  final String? access;
  final String? refresh;
  final int? userId;
  final String? email;
  final String? username;
  final String? role;
  final String? lastLogin;

  DataModel({
    this.access,
    this.refresh,
    this.userId,
    this.email,
    this.username,
    this.role,
    this.lastLogin,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      access: json["access"],
      refresh: json["refresh"],
      userId: json["user_id"],
      email: json["email"],
      username: json["username"],
      role: json["role"],
      lastLogin: json["last_login"],
    );
  }
}
