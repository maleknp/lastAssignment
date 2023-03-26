import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Package.dart';



class PackageService {
  static const String _baseUrl = 'https://api.vanextest.com.ly/api/v1/customer';

  // Future<List<Package>> getPackages(int page) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString('token');
  //
  //
  //   Response response = await get(
  //     Uri.parse('$_baseUrl/packages?page=$page'),
  //     headers: {
  //       'Authorization': 'Bearer $token',
  //     },
  //   );
  //   // final jsonData = jsonDecode(response.body);
  //   // print(jsonData);
  //   if (response.statusCode == 200) {
  //     final jsonData = jsonDecode(response.body);
  //     print("hereee");
  //     print(jsonData["data"]);
  //       final packagesData = jsonData["data"] as List<dynamic>;
  //       return packagesData.map((data) => Package.fromJson(data)).toList();
  //   } else {
  //     throw Exception('Failed to get packages: ${response.statusCode}');
  //   }
  //
  // }

  Future<List<Package>> getPackages(int page, int perPage) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    Response response = await get(
      Uri.parse('$_baseUrl/packages?page=$page&perPage=$perPage'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final packagesData = jsonData["data"] as List<dynamic>;
      return packagesData.map((data) => Package.fromJson(data)).toList();
    } else {
      throw Exception('Failed to get packages: ${response.statusCode}');
    }
  }


}
