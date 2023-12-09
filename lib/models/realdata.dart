
import 'dart:convert';

RealData realDataFromJson(String str) => RealData.fromJson(json.decode(str));

String realDataToJson(RealData data) => json.encode(data.toJson());

class RealData {
  int heartRate;
  int stepCount;
  int caloriesBurned;
  String activityLevel;
  double oxygenLevel;
  int stressLevel;
  double bloodSugar;

  RealData({
    required this.heartRate,
    required this.stepCount,
    required this.caloriesBurned,
    required this.activityLevel,
    required this.oxygenLevel,
    required this.stressLevel,
    required this.bloodSugar,
  });

  factory RealData.fromJson(Map<String, dynamic> json) => RealData(
    heartRate: json["heart_rate"],
    stepCount: json["step_count"],
    caloriesBurned: json["calories_burned"],
    activityLevel: json["activity_level"],
    oxygenLevel: json["oxygen_level"]?.toDouble(),
    stressLevel: json["stress_level"],
    bloodSugar: json["blood_sugar"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "heart_rate": heartRate,
    "step_count": stepCount,
    "calories_burned": caloriesBurned,
    "activity_level": activityLevel,
    "oxygen_level": oxygenLevel,
    "stress_level": stressLevel,
    "blood_sugar": bloodSugar,
  };
}
