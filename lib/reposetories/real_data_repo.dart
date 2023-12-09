import 'package:embs/models/realdata.dart';
import 'package:flutter/foundation.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:embs/helper/http_client.dart';

import '../models/User.dart';

class AuthRepo {
  static final endPoints = {
    "addrealdata": "/api/realdata/new",
    "getAllrealdata":"api/realdata/all"
  };


  static Future<RealData> addRealdata({
    required String name,
    required String email,
    required String password,
    required double weight,
    required double height,
    required String cin,
    required String telephone,
    required String specialRequirements,
    required String role,
  }) async {
    try {
      var response = await HttpClient.post(endPoint: endPoints["signUp"], body: {
        "name": name,
        "email": email,
        "password": password,
        "weight": weight,
        "height": height,
        "cin": cin,
        "telephone": telephone,
        "special_requirements": specialRequirements,
        "role": role,
      });

      if (kDebugMode) {
        print('API Response: $response');
      }
      RealData data = RealData.fromJson(response);

      return data;
    } catch (e) {
      if (kDebugMode) {
        print('Error in signUp: $e');
      }

      // Handle the error accordingly, for now, throw an exception
      throw Exception('Error in signUp: $e');
    }
  }

  static Future<RealData> getAllRealdata() async{
    var value = await HttpClient.get(endPoint: endPoints["getAllrealdata"]);
    //return realdata.fromJson(value as List);
  }
  static Future<void> logOut() async {
    try {
      await HttpClient.post(endPoint: endPoints["logOut"]);
      var pref = await SharedPreferences.getInstance();
      await pref.remove("token");
      await pref.remove("role");
    } catch (e) {
      if (kDebugMode) {
        print('Error in logOut: $e');
      }
    }
  }
}
