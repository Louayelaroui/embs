import 'package:flutter/foundation.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:embs/helper/http_client.dart';

class AuthRepo {
  static final endPoints = {
    "sigIn": "/api/auth/signin",
    "sigUp": "/api/auth/signup",

  };
  static Future<void> signIn({required String email, required String password}) async {
    try {
      var response = await HttpClient.post(endPoint: endPoints["sigIn"], body: {
        "email": email,
        "password": password
      });

      if (kDebugMode) {
        print('API Response: $response');
      }

      var pref = await SharedPreferences.getInstance();

      // Use 'token' instead of 'access_token'
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
        // Handle the case where there is no token in the response
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error in signIn: $e');
      }
      // Additional error handling
    }
  }
  static Future<void> signUp({required String role , required String name,required String email, required String password}) async {
    {
      var response = await HttpClient.post(endPoint: endPoints["signup"], body: {
        "email": email,
        "password": password,
        "name":name,
        "role":role
      });

      if (kDebugMode) {
        print('API Response: $response');
      }
    }

  }


  static Future<void> logOut() async {
    var pref = await SharedPreferences.getInstance();
    await pref.remove("token");
    await pref.remove("role");
  }


}