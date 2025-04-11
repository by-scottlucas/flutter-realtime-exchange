import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class CurrencyService {
  final String _baseApi = dotenv.env['API_URL'] ?? "";

  Future<Map?> getData() async {
    String request = _baseApi;
    try {
      http.Response response = await http.get(Uri.parse(request));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }
}
