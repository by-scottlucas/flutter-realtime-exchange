import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyService {
  final String _baseApi = "https://economia.awesomeapi.com.br/json/last/USD-BRL,EUR-BRL";

  Future<Map?> getData() async {
    String request = _baseApi;
    try {
      http.Response response = await http.get(Uri.parse(request));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
