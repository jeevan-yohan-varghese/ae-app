import 'dart:convert';

import 'package:ae_task_app/data/helpers/login_response.dart';
import 'package:ae_task_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class LoginRepo {
  Future<LoginResponse> loginAsync(String token) async {
    //debugPrint("*********************Google ID token : $token ");
    final response = await http.post(Uri.parse('$BASE_URL/auth/login?apiKey=${dotenv.env['API_KEY']}'),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(<String, String>{'authtoken': token}));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //debugPrint(response.body);
      debugPrint(response.body);
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      throw Exception("Not registered");
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      debugPrint(response.body);
      throw Exception('Failed to fetch');
    }
  }

  Future<LoginResponse> signUpAsync(
      String token, String name, String email, String regNo) async {
    //debugPrint("*********************Google ID token : $token ");
    debugPrint("API key ${dotenv.env['API_KEY']}");
    final response = await http.post(Uri.parse('$BASE_URL/auth/signup?apiKey=${dotenv.env['API_KEY']}'),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(<String, String>{
          'authtoken': token,
          'email': email,
          'name': name,
          'regNo': regNo
        }));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //debugPrint(response.body);
      debugPrint(response.body);
      return LoginResponse.fromJson(jsonDecode(response.body));
    }else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      debugPrint(response.body);
      throw Exception('Failed to fetch');
    }
  }
}
