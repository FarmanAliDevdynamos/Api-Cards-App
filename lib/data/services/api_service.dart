import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://jsonplaceholder.typicode.com";

  Future<List<dynamic>> get(String endpoint) async {
    final response = await http.get(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3',
      },
    );
    print("API response: ${response.body}"); // Debug print
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print("API error: ${response.statusCode}"); // Debug print
      throw Exception("Failed to fetch data: ${response.statusCode}");
    }
  }
}
