import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../component/CurvedLisstItem.dart';

class RealDataPage extends StatefulWidget {
  @override
  State<RealDataPage> createState() => _RealDataPageState();
}

class _RealDataPageState extends State<RealDataPage> {
  final healthData = {
    "heart_rate": 75,
    "step_count": 10000,
    "calories_burned": 500,
    "activity_level": "Moderate",
    "oxygen_level": 98.5,
    "stress_level": 3,
    "blood_sugar": 90.5,
  };
   static TextEditingController _textFieldController = TextEditingController();
@override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Data'),
        backgroundColor: Colors.blue[900],
      ),
      body: ListView.builder(
        itemCount: healthData.length,
        itemBuilder: (context, index) {
          var key = healthData.keys.toList()[index];
          var value = healthData[key];
          IconData icon = getIcon(key);


          return CurvedListItem(
            title: '$key'.tr(),
            titleshowD:'$key'.tr(),
            time: '$value',
            icon: icon,
            color: index % 2 == 0 ? Colors.white : Colors.blue[600],
            iconColor: index % 2 == 0 ? Colors.blue[600] : Colors.white,
            textcolor1: index % 2 == 0 ? Colors.blue[600] : Colors.white,
            textcolor2: index % 2 == 0 ? Colors.blue[600] : Colors.white,
            nextColor: index % 2 == 0 ? Colors.blue[600] : Colors.white,
            textFieldController: _textFieldController,
          );
        },
      ),
    );
  }

  IconData getIcon(String attribute) {
    switch (attribute) {
      case "heart_rate":
        return Icons.favorite;
      case "step_count":
        return Icons.directions_walk;
      case "calories_burned":
        return Icons.whatshot;
      case "activity_level":
        return Icons.directions_run;
      case "oxygen_level":
        return Icons.waves;
      case "stress_level":
        return Icons.sentiment_very_satisfied;
      case "blood_sugar":
        return Icons.local_hospital;
      default:
        return Icons.error;
    }
  }
}