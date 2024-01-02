import 'dart:io';
import 'package:http/http.dart' as http;

class ApiHelper {
  postData({required data, required apiUrl}) async {
    try {
      final res =  await http.post(Uri.parse(apiUrl), body: data);
      return res;
    } on SocketException {
      throw Exception("No Internet");
    } on HttpException {
      throw Exception("Couldn't find the post ?");
    } on FormatException {
      throw Exception("Bad response format ?");
    }catch(e){
      print(e);
    }
  }
  getData({required apiUrl}) async {
    try {
      print(Uri.parse(apiUrl));
      final res =  await http.get(Uri.parse(apiUrl));

      return res;
    } on SocketException {
      throw Exception("No Internet");
    } on HttpException {
      throw Exception("Couldn't find the post ?");
    } on FormatException {
      throw Exception("Bad response format ?");
    }catch(e){
      print(e);
    }
  }
}
