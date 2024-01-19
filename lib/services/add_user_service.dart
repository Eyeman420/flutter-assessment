// Import the required packages
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  final Uri apiUrl = Uri.parse('https://reqres.in/api/users');

  Future<http.Response> addUser(
      {required String firstName,
      required String lastName,
      required String email}) async {
    // The user data
    Map<String, dynamic> userData = {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
    };

    // Send POST
    final response = await http.post(
      apiUrl,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(userData),
    );

    return response;
  }
}
