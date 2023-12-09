import 'package:flutter/foundation.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:embs/helper/http_client.dart';

import '../models/User.dart';

class AuthRepo {
  static final endPoints = {
    "signIn": "/api/auth/signin",
    "signUp": "/api/auth/signup",
    "logOut": "/api/auth/logout",
    "getAllUsers": "/api/auth/logout",

  };

  static Future<User> signIn({
    required String email,
    required String password,
  }) async {
    try {
      var response = await HttpClient.post(endPoint: endPoints["signIn"], body: {
        "email": email,
        "password": password,
      });

      if (kDebugMode) {
        print('API Response: $response');
      }

      User user = User.fromJson(response);

      var pref = await SharedPreferences.getInstance();

      if (response.containsKey("token") && response["token"] != null) {
        String token = response["token"];
        await pref.setString("token", token);

        Map<String, dynamic> tokenData = Jwt.parseJwt(token);
        String role = "";
        int userID = 0;

        if (tokenData.containsKey("role_name") && tokenData["role_name"] != null) {
          role = tokenData["role_name"];
          await pref.setString("role", role);
          if (kDebugMode) {
            print('Role: $role');
          }
        }
        if (tokenData.containsKey("user_id") && tokenData["user_id"] != null) {
          userID = tokenData["user_id"];
          await pref.setInt("userID", userID);
          if (kDebugMode) {
            print('User ID: $userID');
          }
        }
      } else {
        if (kDebugMode) {
          print('No token found in the response');
        }
        // Throw an exception or handle the absence of the token as needed
        throw Exception('No token found in the response');
      }

      return user; // Ensure a meaningful return statement
    } catch (e) {
      if (kDebugMode) {
        print('Error in signIn: $e');
      }
      // Handle the error accordingly, for now, throw an exception
      throw Exception('Error in signIn: $e');
    }
  }

  static Future<User> signUp({
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
    User user = User.fromJson(response);

      return user;
    } catch (e) {
      if (kDebugMode) {
        print('Error in signUp: $e');
      }

      // Handle the error accordingly, for now, throw an exception
      throw Exception('Error in signUp: $e');
    }
  }

  static Future<Users> getAllUsers() async{
    var value = await HttpClient.get(endPoint: endPoints["getAllUsers"]);
    return Users.fromJson(value as List);
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
