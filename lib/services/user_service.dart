import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  static const String baseUrl = "http://localhost:8080/api/users"; // change if needed

  static Future<int> getTotalUsers() async {
    final response = await http.get(Uri.parse("$baseUrl/count"));

    if (response.statusCode == 200) {
      return int.parse(response.body);
    } else {
      throw Exception("Failed to fetch total users");
    }
  }
}
