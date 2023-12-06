import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Doctor View/Consultation.dart';
import 'Doctor View/Edit_User_Profile.dart';
import 'Doctor View/UsersList.dart';
import 'User/Consultation.dart';
import 'User/Edit_User_Profile.dart';
import 'User/Real_data.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}
class _UserPageState extends State<UserPage> {
  int index = 2;

  List<Widget> userWidgets = [
    RealDataPage(),
    Consultation(),
    ProfilePage(),
  ];

  List<Widget> doctorWidgets = [
    ConsultationView(),
    ProfilePageDoctor(),
    UsersPage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: SharedPreferences.getInstance().then((pref) => pref.getString("role")),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          String role = snapshot.data ?? "";
          List<Widget> selectedWidgets = (role.toLowerCase() == 'doctor') ? doctorWidgets : userWidgets;

          return Scaffold(
            body: selectedWidgets[index],
            bottomNavigationBar: SizedBox(
              height: 50,
              child: ConvexAppBar(
                backgroundColor: const Color(0xFF00a5cb),
                items: [
                  TabItem(icon: Icons.medical_information, title: 'RealDataPage'.tr()),
                  TabItem(icon: Icons.history, title: 'Consultation'.tr()),
                  TabItem(icon: Icons.account_circle, title: 'Profile'.tr()),
                ],
                initialActiveIndex: index,
                onTap: (int i) {
                  setState(() {
                    index = i;
                  });
                },
              ),
            ),
            backgroundColor: Colors.white,
          );
        }
      },
    );
  }
}
