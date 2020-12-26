
  import 'package:http/http.dart' as http;

class ApiService {


  Future<http.Response> getApiData(String url) async {
 
        http.Response response = await http.get(url);
      return response;
    
    
 


  }
  Future<http.Response> fetfakeApiData(String url) async {
    var a ='http://lo.com/ds';
    http.Response response = await http.get(a);
    return response;
  }


}
 