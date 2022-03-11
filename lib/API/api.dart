import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:medfest/services/storage.dart';

class API {
  String baseUrl = 'https://www.medfestcare.com:8843/';

  Future<http.Response?> getReq(String url) async {
    try {
      var token = await Storage.readData("token");
      Map<String, String> headers = <String, String>{
        'Authorization': 'Bearer $token'
      };
      log(token);
      var link = Uri.parse('$baseUrl$url');
      http.Response response = await http.get(link, headers: headers);
      
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
