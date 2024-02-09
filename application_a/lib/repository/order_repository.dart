import 'dart:convert';

import 'package:application_a/repository/repository.dart';
import 'package:application_a/until/model/mode.dart';
import 'package:http/http.dart' as http;

class OrderRepository {
  OrderRepository({
    required Repository repository,
    required String uri,
    http.Client? client,
    String? userAgent,
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

  Future<List<OrderModel>> getOrders({
    String? startDate = '2024-01-23',
    String? endDate = '2024-01-23',
  }) async {
    try {
      // throw 401;
      final url = Uri.parse(
          '$_uri/query_orders?start_date=$startDate&end_date=$endDate&is_printed=&keyword=&status=&courier_code=');

      final response = await _client.get(
        url,
        headers: _headers,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)["data"] as List;
        return data.map((e) => OrderModel.fromJson(e)).toList();
      } else if (response.statusCode == 401) {
        throw 401;
      } else {
        return [];
      }
    } catch (e) {
      if (e == 401) {
        throw 401;
      }
      return [];
    }
  }
}
