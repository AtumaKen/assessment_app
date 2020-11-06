import 'dart:convert';

import 'package:assessment_app/model/http_exception.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class AuthService{

  String _token;
  String _userId;
  DateTime _expiryDate;

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, "signUp");
  }

  Future<void> logIn(String email, String password) async {
    return _authenticate(email, password, "signInWithPassword");
  }
  Future<void> _authenticate(
      String email, String password, String urlBit) async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:$urlBit?key=AIzaSyAYKQU7bgy2k6xqOy_p61CEinm-cMt6dTY";

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {"email": email, "password": password, "returnSecureToken": true},
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData["error"] != null) {
        throw HttpException(responseData["error"]["message"]);
      }
      _token = responseData["idToken"];
      _userId = responseData["localId"];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData["expiresIn"])));
      // _autoLogout();
      // notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        "token": _token,
        "userId": _userId,
        "expiryDate": _expiryDate.toIso8601String(),
      });
      prefs.setString("userData", userData);
    } catch (error) {
      throw error;
    }
  }
}