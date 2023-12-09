import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Doctor/Profile/Profile.dart';
import 'Doctor/UserList/UserDetails/user_screen.dart';
import 'Doctor/UserList/UsersList.dart';
import 'Doctor/family/familyScreen.dart';
import 'User/Consultation.dart';
import 'User/Profile.dart';
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
    FamilyScreen(),
    UsersPage(),
    ProfilePageDoctor(),

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
          List<Widget> selectedWidgets = (role.toLowerCase() == 'root') ? doctorWidgets : userWidgets;

          return Scaffold(
            body: selectedWidgets[index],
            bottomNavigationBar: SizedBox(
              height: 50,
              child: ConvexAppBar(
                backgroundColor: Colors.blue[800],
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
