import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static SharedPreferences? localStorage;
  static Future<SharedPreferences> initialLocalStorage() async {
    localStorage ??= await SharedPreferences.getInstance();
    return localStorage!;
  }

  static setUserId(int user) {
    localStorage?.setInt("userid",user);
  }
  static getUserId() {
    return localStorage?.getInt("userid");
  }
  static setLoginId(int login) {
    localStorage?.setInt("loginid",login);
  }
  static getLoginId() {
   return  localStorage?.getInt("loginid");
  }
  static clear(){
    localStorage?.clear();

  }

}
