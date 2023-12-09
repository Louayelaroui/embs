import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:embs/helper/http_client.dart';
import '../models/realdata.dart';

class RealDataRepo {
  static final endPoints = {
    "addRealData": "/api/realdata/new",
    "getAllRealData": "api/realdata/all"
  };

  static Future<RealData> addRealData({
    required int heartRate,
    required int stepCount,
    required int caloriesBurned,
    required String activityLevel,
    required double oxygenLevel,
    required int stressLevel,
    required double bloodSugar,
    required int bloodPressure,
  }) async {
    try {
      var response = await HttpClient.post(endPoint: endPoints["addRealData"], body: {
        "heart_rate": heartRate,
        "step_count": stepCount,
        "calories_burned": caloriesBurned,
        "activity_level": activityLevel,
        "oxygen_level": oxygenLevel,
        "stress_level": stressLevel,
        "blood_sugar": bloodSugar,
        "blood_pressure": bloodPressure,
      });

      if (kDebugMode) {
        print('API Response: $response');
      }

      // Assuming the response is in the same format as the RealData model
      RealData data = RealData.fromJson(response);

      return data;
    } catch (e) {
      if (kDebugMode) {
        print('Error in addRealData: $e');
      }

      // Handle the error accordingly, for now, throw an exception
      throw Exception('Error in addRealData: $e');
    }
  }

  static Future<List<RealData>> getAllRealData() async {
    try {
      var value = await HttpClient.get(endPoint: endPoints["getAllRealData"]);
      return RealDataNotifier.fromJson(value as List).users;
    } catch (e) {
      if (kDebugMode) {
        print('Error in getAllRealData: $e');
      }
      // Handle the error accordingly, for now, throw an exception
      throw Exception('Error in getAllRealData: $e');
    }
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
