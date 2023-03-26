import 'dart:convert';
import 'package:http/http.dart';

class AuthService {
  static Future<Response> login(String email, String password) async {
    print(email);
    print(password);

  final url = Uri.parse('https://api.vanextest.com.ly/api/v1/authenticate');
    Response response = await post(
      url,
        body: {
          'email' : email,
          'password' : password
        }
    );

    if (response.statusCode == 200 || response.statusCode == 401) {
      return response;
    } else {
      throw Exception('حدث خطأ ما الرجاء إعادة المحاولة');
    }

  }
}
