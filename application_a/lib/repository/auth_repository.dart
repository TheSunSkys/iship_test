import 'dart:convert';

import 'package:application_a/repository/repository.dart';
import 'package:application_a/until/model/auth.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  AuthRepository({
    required Repository repository,
    required String uri,
    http.Client? client,
  })  : _uri = uri,
        _client = client ?? http.Client();

  final String _uri;
  final http.Client _client;

  late Map<String, String> _headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

  void setTokenHeader(String token) {
    _headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token",
    };
  }

  Future<AuthModel> loginSubmit({
    required String phone,
    required String password,
  }) async {
    try {
      final url = Uri.parse('$_uri/login');

      final bodyData = {
        "phone": phone,
        "password": password,
      };

      final response = await _client.post(
        url,
        body: jsonEncode(bodyData),
        headers: _headers,
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'];
        return AuthModel.fromJson(data);
      } else {
        final message = jsonDecode(response.body)['message'];
        print(message);
        throw message;
      }
    } catch (e) {
      rethrow;
    }
  }
}
