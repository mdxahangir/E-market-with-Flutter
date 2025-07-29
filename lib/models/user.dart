class UserResponse {
  final String fullName;
  final String email;
  final String role;

  UserResponse({
    required this.fullName,
    required this.email,
    required this.role,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      fullName: json['fullName'],
      email: json['email'],
      role: json['role'],
    );
  }
}
