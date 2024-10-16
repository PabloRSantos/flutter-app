import 'package:http/http.dart' as http;

class HttpService {
  final _client = http.Client();
  final String baseUrl = "https://economia.awesomeapi.com.br/json";

  Future get({required String url}) async {
    return await _client.get(Uri.parse(baseUrl + url));
  }
}
