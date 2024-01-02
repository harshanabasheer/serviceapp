import 'dart:convert';

class NetWorkError{
  static netWorkError({required response}){
    print(response.body);

    switch(response.statusCode){
      case 400:
        print(response.body);
        throw Exception(jsonDecode(response.body)['message']);
      case 404:
        throw Exception('Not found');
      case 500:
        throw Exception('Internal server error');
        default:
          throw Exception('Something went wrong');
    }

  }
}