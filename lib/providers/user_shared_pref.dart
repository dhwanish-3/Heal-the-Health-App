import 'dart:convert';

import 'package:heal_the_health_app/constants/imports.dart';

class UserShared with ChangeNotifier {
  Future<bool> saveUser(String user) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(user);
    sp.setString('User', jsonString);
    notifyListeners();
    return true;
  }

  Future<String> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String user = sp.getString('User') ?? 'patient';
    // PatientUser user =
    //     PatientUser.fromMap(jsonDecode(sp.getString('User') as String));
    return user;
  }

  // Future<bool> remove() async {
  //   final SharedPreferences sp = await SharedPreferences.getInstance();
  //   sp.setBool('isLogin', false);
  //   return sp.clear();
  // }
}
