import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:serviceapp/services/preference_services.dart';
import 'package:serviceapp/utils/helper/api_helper.dart';
import '../model/booking_model.dart';
import '../model/category_model.dart';
import '../model/login_model.dart';
import '../model/service_model.dart';
import '../model/user_model.dart';
import '../utils/constants/api_constants.dart';
import '../utils/net_work_error/net_work_error.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final _apiHelper = ApiHelper();
  Future<LoginModel> signIn(
      {required String email, required String password}) async {
    var response = await _apiHelper.postData(data: {
      'UserName': email,
      'Password': password,
    }, apiUrl: Apiconstants.baseurl + Apiconstants.login);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      var loginModel = LoginModel.fromJson(responseData);
      LocalStorage.setLoginId(loginModel.data!.loginId!);
      LocalStorage.setUserId(loginModel.data!.userid!);
      return loginModel;
    } else {
      throw NetWorkError.netWorkError(response: response);
    }
  }

  Future<UserModel> registerUser({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    var data = {
      "Name": name,
      "Phone": phone,
      "Email": email,
      "Password": password,
    };
    var response = await _apiHelper.postData(
      data: data,
      apiUrl: Apiconstants.baseurl + Apiconstants.userReg,
    );
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body)["data"]);
    } else {
      throw NetWorkError.netWorkError(response: response);
    }
  }

  Future<CategoryModel> getAllCategories() async {
    var response = await _apiHelper.getData(
        apiUrl: Apiconstants.baseurl + Apiconstants.getCategory);

    if (response.statusCode == 200) {
      return CategoryModel.fromJson(jsonDecode(response.body));
    } else {
      throw NetWorkError.netWorkError(response: response);
    }
  }

  Future<List<ServiceModel>> getAllService(int categoryId) async {
    var response = await _apiHelper.getData(
        apiUrl: Apiconstants.baseurl +
            Apiconstants.getService +
            categoryId.toString());
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data']
          .map<ServiceModel>((e) => ServiceModel.fromJson(e))
          .toList();
    } else {
      throw NetWorkError.netWorkError(response: response);
    }
  }

  Future<List<ServiceModel>> recommentedService() async {
    var response = await _apiHelper.getData(
        apiUrl: Apiconstants.baseurl + Apiconstants.recommentedService);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data']
          .map<ServiceModel>((e) => ServiceModel.fromJson(e))
          .toList();
    } else {
      throw NetWorkError.netWorkError(response: response);
    }
  }

  Future<ServiceModel> getOneService(int serviceId) async {
    var response = await _apiHelper.getData(
        apiUrl: Apiconstants.baseurl +
            Apiconstants.getOneService +
            serviceId.toString());

    if (response.statusCode == 200) {
      return ServiceModel.fromJson(jsonDecode(response.body)['data']);
    } else {
      throw NetWorkError.netWorkError(response: response);
    }
  }

  //payment
  Future<String> addPayment(
      {required String userName,
      required String password,
      required Map<String, dynamic> data}) async {
    var response = await _apiHelper.paymentPost(
      userName: userName,
      password: password,
      data: data,
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)["id"];
    } else {
      throw 'Somthing went wrong';
    }
  }

  //place booking
  Future<BookingModel> placeBooking(
      {
      required userId,
      required userName,
      required serviceId,
      required serviceName,
      required date,
      required time,
      required status,
      required address,
      required price}) async {
    var response = await _apiHelper.postData(data: {
      'UserId': userId,
      'UserName': userName,
      'ServiceId': serviceId,
      'ServiceName': serviceName,
      'Date': date,
      'Time': time,
      'Status': status,
      'Address': address,
      'Price': price,
    }, apiUrl: Apiconstants.baseurl + Apiconstants.placeBooking);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);

      var placeBookingModel = BookingModel.fromJson(responseData);
      return placeBookingModel;
    } else {
      throw NetWorkError.netWorkError(response: response);
    }
  }

//all bookings
  Future<List<BookingModel>> getAllBookings() async {
    var response = await _apiHelper.getData(
        apiUrl: Apiconstants.baseurl + Apiconstants.getAllBooking);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data']
          .map<BookingModel>((e) => BookingModel.fromJson(e))
          .toList();
    } else {
      throw NetWorkError.netWorkError(response: response);
    }
  }

//cleaning service
  Future<List<ServiceModel>> getCleaningService() async {
    final int cleanindId = 5;

    var response = await _apiHelper.getData(
        apiUrl: Apiconstants.baseurl +
            Apiconstants.getService +
            cleanindId.toString());

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data']
          .map<ServiceModel>((e) => ServiceModel.fromJson(e))
          .toList();
    } else {
      throw NetWorkError.netWorkError(response: response);
    }
  }

  //get one register
  Future<UserModel> getOneUser(int userId) async {
    var response = await _apiHelper.getData(
        apiUrl: Apiconstants.baseurl +
            Apiconstants.getOneRegister +
            userId.toString());
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body)['data']);
    } else {
      throw NetWorkError.netWorkError(response: response);
    }
  }

  // update user
  Future<UserModel> updateUser(int userId, String name, String email, String phone, File photo) async {
    try {
      var apiUrl = Apiconstants.baseurl + Apiconstants.updateRegister + userId.toString();

      var request = http.MultipartRequest('PUT', Uri.parse(apiUrl));
      request.fields['Name'] = name;
      request.fields['Email'] = email;
      request.fields['Phone'] = phone;
      if (photo != null) {
        request.files.add(await http.MultipartFile.fromPath('Photo', photo.path));
      }
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        print(responseBody);
        return UserModel.fromJson(jsonDecode(responseBody));
      } else {
        throw NetWorkError.netWorkError(response: await http.Response.fromStream(response));
      }
    } catch (e) {
      print('Failed to update profile: $e');
      throw e;
    }
  }

  //search
  Future<dynamic> searchService(
      {required String query, }) async {
    print("object");
    var response = await _apiHelper.postData(data: {
      'query': query,
    }, apiUrl: Apiconstants.baseurl + Apiconstants.searchService);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      var data = responseData["data"];
      return data;

    } else {
      throw NetWorkError.netWorkError(response: response);
    }
  }

  //forgotpassword
  Future<dynamic> forgotPassword(
      {required String email, required String password}) async {
    var response = await _apiHelper.postData(data: {
      'username': email,
      'new_password': password,
    }, apiUrl: Apiconstants.baseurl + Apiconstants.forgotPassword);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      return responseData;
    } else {
      throw NetWorkError.netWorkError(response: response);
    }
  }



// Future<String> sendOtp({
  //   required BuildContext context,
  //   required String email,
  // }) async {
  //   var data = {
  //     "Email": email,
  //   };
  //   var response = await _apiHelper.postData(
  //     data: data,
  //     apiUrl: Apiconstants.baseurl + Apiconstants.sendOtp,
  //   );
  //   if (response.statusCode == 200) {
  //   return jsonDecode(response.body)['message'];
  //
  //   } else {
  //     throw NetWorkError.netWorkError(response: response);
  //   }
  // }
}
