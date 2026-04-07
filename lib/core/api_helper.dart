import 'dart:convert';
import 'dart:developer';

import 'package:cab_zing/Data/local_storage.dart';
import 'package:cab_zing/core/constants.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  final LocalStorage storage;
  ApiHelper(this.storage);

  static const String baseUrl = '';

  Future<Map<String, String>> getHeaders() async {
    final token = await storage.read(accessToken);

    return {
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  Future<dynamic> apiGet(String endpoint) async {
    try {
      final headers = await getHeaders();
      final response = await http.get(Uri.parse('$endpoint'), headers: headers);

      return handleResponse(response);
    } catch (e) {
      print('Error occured : $e');
      throw Exception("GET Error: $e");
    }
  }

  Future<dynamic> apiPost(String endpoint, Map<String, dynamic> body) async {
    try {
      final headers = await getHeaders();
      final response = await http.post(
        Uri.parse(endpoint),
        headers: headers,
        body: jsonEncode(body),
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
