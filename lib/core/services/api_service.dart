import 'package:http/http.dart' as http;

class ApiService {
  var client = http.Client();

  Future<http.Response> fetApiData(String url) async {
    http.Response response = await client.get(url);
    return response;
  }
}
