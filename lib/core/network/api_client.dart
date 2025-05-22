import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/core/errors/exceptions.dart';

class ApiClient {
  final http.Client client;

  ApiClient({required this.client});

  Future<dynamic> get(String url, {Map<String, dynamic>? params}) async {
    try {
      final uri = Uri.parse(url).replace(queryParameters: params);
      final response = await client.get(uri);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw ServerException('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException('Failed to load data: ${e.toString()}');
    }
  }
}
