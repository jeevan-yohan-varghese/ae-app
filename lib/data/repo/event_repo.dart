import 'dart:convert';

import 'package:ae_task_app/data/helpers/general_response.dart';
import 'package:ae_task_app/data/helpers/login_response.dart';
import 'package:ae_task_app/data/helpers/my_event_response.dart';
import 'package:ae_task_app/data/models/event.dart';
import 'package:ae_task_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class EventRepo {
  Future<GeneralResponse> createEventAsync(String jwt, String name,
      String startDate, String endDate, String venueId, int seats) async {
    //debugPrint("*********************Google ID token : $token ");
    final response = await http.post(
        Uri.parse('$BASE_URL/api/newEvent?apiKey=${dotenv.env['API_KEY']}'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $jwt"
        },
        body: jsonEncode(<String, dynamic>{
          'name': name,
          'startdate': startDate,
          'endDate': endDate,
          'venueId': venueId,
          'seats': seats
        }));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //debugPrint(response.body);
      debugPrint(response.body);
      return GeneralResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      throw Exception("Not registered");
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      debugPrint(response.body);
      throw Exception('Failed to fetch');
    }
  }

  Future<GetEventResponse> getAllEvents() async {
    //debugPrint("*********************Google ID token : $token ");
    final response = await http.get(
      Uri.parse('$BASE_URL/api/getAllEvents?apiKey=${dotenv.env['API_KEY']}'),
      headers: {
        "Content-Type": "application/json",
        //"Authorization": "Bearer $jwt"
      },
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //debugPrint(response.body);
      debugPrint(response.body);
      return GetEventResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      throw Exception("Not registered");
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      debugPrint(response.body);
      throw Exception('Failed to fetch');
    }
  }

  Future<MyEventResponse> getMyEvents(String jwt) async {
    //debugPrint("*********************Google ID token : $token ");
    final response = await http.get(
      Uri.parse('$BASE_URL/api/myEvents?apiKey=${dotenv.env['API_KEY']}'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $jwt"
      },
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //debugPrint(response.body);
      debugPrint(response.body);
      return MyEventResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      throw Exception("Not registered");
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      debugPrint(response.body);
      throw Exception('Failed to fetch');
    }
  }

  Future<GeneralResponse> registerForEvent(String jwt, String eventId) async {
    //debugPrint("*********************Google ID token : $token ");
    final response = await http.post(
        Uri.parse(
            '$BASE_URL/api/registerForEvent?apiKey=${dotenv.env['API_KEY']}'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $jwt"
        },
        body: jsonEncode(<String, dynamic>{
          'eventId': eventId,
        }));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //debugPrint(response.body);
      debugPrint(response.body);
      return GeneralResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      throw Exception(GeneralResponse.fromJson(jsonDecode(response.body)).message);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      debugPrint(response.body);
      throw Exception('Failed to fetch');
    }
  }
}
