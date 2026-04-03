import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiHelper {
  static const String baseUrl = '';
  static Map<String, String> headers = {"Content-Type": "application/json"};

  Future<dynamic> apiGet(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: headers,
      );
      return handleResponse(response);
    } catch (e) {
      print('Error occured : $e');
      throw Exception("GET Error: $e");
    }
  }

  Future<dynamic> apiPost(String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await http.post(
        Uri.parse('$endpoint$endpoint'),
        headers: headers,
        body: jsonEncode(json),
      );
      return handleResponse(response);
    } catch (e) {
      print('Error occured: $e');
      throw Exception('POST error: $e');
    }
  }

  static dynamic handleResponse(http.Response response) {
    final data = jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return data;
    } else {
      throw Exception("API Error: ${response.statusCode} - ${data.toString()}");
    }
  }
}
