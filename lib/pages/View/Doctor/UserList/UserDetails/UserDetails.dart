import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../models/User.dart';
import '../../../../components/Custum_static_avatar.dart';
import '../../../component/PrintPdfBtn.dart';
import '../../../component/user_info.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({Key? key}) : super(key: key);

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  String bmi(result) {
    if (result >= 30) {
      return 'Obese'.tr();
    } else if (result > 25 && result < 30) {
      return 'Overweight'.tr();
    } else if (result >= 18.5 && result <= 24.9) {
      return 'Normal'.tr();
    } else {
      return 'Thin'.tr();
    }
  }

  final GlobalKey _screenKeyPrifile = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),  // Icon for modification
            onPressed: () {
            },
          ),
          IconButton(
            icon: Icon(Icons.medical_services),  // Icon for entering consultation
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil("/Userdata", (predicate) => false);

            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Your other widgets go here
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.02,
            left: MediaQuery.of(context).size.width * 0.7,
            child: Consumer<User>(
              builder: (context, user, child) {
                return PrintPdfBtn(
                  text: "print PDF".tr(),
                  screenKey: _screenKeyPrifile,
                  fileName: "${user.name}  ${user.cin}",
                );
              },
            ),
          ),
          RepaintBoundary(
            key: _screenKeyPrifile,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Consumer<User>(
                builder: (context, user, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CustomStaticAvatar(urlImage: ""),
                      ),
                      UserInfo(title: "Name".tr(), text: user.name ?? "test"),
                      UserInfo(title: "height".tr(), text: user.height.toString() ?? "60"),
                      UserInfo(title: "weight".tr(), text: user.weight.toString() ?? "70"),
                      UserInfo(title: "Email".tr(), text: user.email ?? "tset@gmail.com"),
                      UserInfo(title: "cin".tr(), text: user.cin ?? "1245155"),
                      UserInfo(title: "Phone_Number".tr(), text: user.telephone ?? "507040663"),
                      Builder(
                        builder: (context) {
                          if (user.weight == null || user.height == null) return const Text("");
                          double? height = double.tryParse(user.height! as String);
                          double? weight = double.tryParse(user.weight! as String);
                          if (weight == null || height == null) return const Text("");
                          return UserInfo(
                            title: "BMI".tr(),
                            text: bmi(weight / pow(height, 2)),
                          );
                        },
                      ),

                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
