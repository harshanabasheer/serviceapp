import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:serviceapp/model/user_model.dart';

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
  putData({required data, required apiUrl}) async {
    try {
      final res =  await http.put(Uri.parse(apiUrl),body: data);
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

 //payment
  Future<http.Response> paymentPost({required String userName,required String password,required Map<String,dynamic>  data}) {
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$userName:$password'))}';
    return  http.post(
      Uri.https(
          "api.razorpay.com", "v1/orders"),
      headers: <String, String>{
        "Content-Type": "application/json",
        'authorization': basicAuth,
      },
      body: jsonEncode(data),
    );
  }



}
