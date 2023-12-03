
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:embs/pages/User%20View/Real_data.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'Consultation.dart';
import 'Edit_User_Profile.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {


  int index = 2;

  List<Widget> bodies = [
    RealDataPage(),
    UserBody(),
    Consultation(),
    ProfilePage(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: bodies[index],
        bottomNavigationBar:
        SizedBox(
          height: 50,
          child: ConvexAppBar(
            backgroundColor:  const Color(0xFF00a5cb),
            items: [
              TabItem(icon: Icons.medical_information, title: 'RealDataPage'.tr()),
              TabItem(icon: Icons.history, title: 'UserBody'.tr()),
              TabItem(icon: Icons.quiz, title: 'Consultation'.tr()),
              TabItem(icon: Icons.people, title: 'Profile'.tr()),

            ],
            initialActiveIndex: index,
            onTap: (int i) {
              setState(() {
                index = i;
              });
              }
          ),
        ),
        backgroundColor: Colors.white,

      );
  }
}


class UserBody extends StatefulWidget {
  const UserBody({Key? key}) : super(key: key);

  @override
  State<UserBody> createState() => _UserBodyState();
}

class _UserBodyState extends State<UserBody> {
  String  bmi(result) {
    if (result >= 30) {

      return 'Obese'.tr();
    } else if (result > 25 && result < 30) {

      return 'Overweight'.tr();
    } else if (result >= 18.5 && result <= 24.9){
      return 'Normal'.tr();
    } else {
      return 'Thin'.tr();
    }
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


        ],
      ),
    );
  }
}
