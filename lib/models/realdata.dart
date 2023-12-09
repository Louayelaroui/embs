import 'dart:convert';
import 'package:flutter/cupertino.dart';

class RealData {
  // Add 'id' property
  String id;
  int heartRate;
  int stepCount;
  int caloriesBurned;
  String activityLevel;
  double oxygenLevel;
  int stressLevel;
  double bloodSugar;

  RealData({
    required this.id, // Add 'id' to the constructor
    required this.heartRate,
    required this.stepCount,
    required this.caloriesBurned,
    required this.activityLevel,
    required this.oxygenLevel,
    required this.stressLevel,
    required this.bloodSugar,
  });

  factory RealData.fromJson(Map<String, dynamic> json) => RealData(
    id: json["id"],
    heartRate: json["heart_rate"],
    stepCount: json["step_count"],
    caloriesBurned: json["calories_burned"],
    activityLevel: json["activity_level"],
    oxygenLevel: json["oxygen_level"]?.toDouble(),
    stressLevel: json["stress_level"],
    bloodSugar: json["blood_sugar"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id, // Include 'id' in the toJson method
    "heart_rate": heartRate,
    "step_count": stepCount,
    "calories_burned": caloriesBurned,
    "activity_level": activityLevel,
    "oxygen_level": oxygenLevel,
    "stress_level": stressLevel,
    "blood_sugar": bloodSugar,
  };
}

class RealDataNotifier extends ChangeNotifier {
  List<RealData> users = [];

  RealDataNotifier.fromJson(List<dynamic> json) {
    users = json.map((e) => RealData.fromJson(e)).toList();
    notifyListeners();
  }

  List<dynamic> toJson() {
    return users.map((e) => e.toJson()).toList();
  }

  setUsers(List<RealData> userList) {
    users = userList;
    notifyListeners();
  }

  addUser(RealData user) {
    users.add(user);
    notifyListeners();
  }

  updateUser(String id, RealData user) {
    users = users.map((e) {
      if (e.id == id) {
        return user;
      }
      return e;
    }).toList();

    notifyListeners();
  }

  deleteUser(String id) {
    users = users.where((element) => element.id != id).toList();
    notifyListeners();
  }
}
