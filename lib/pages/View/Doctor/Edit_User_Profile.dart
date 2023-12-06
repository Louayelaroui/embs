import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/route.dart';
import '../../../reposetories/auth_repository.dart';
import '../component/Profile_widget.dart';
class ProfilePageDoctor extends StatefulWidget {
  const ProfilePageDoctor({Key? key}) : super(key: key);

  @override
  State<ProfilePageDoctor> createState() => _ProfilePageDoctorState();
}

class _ProfilePageDoctorState extends State<ProfilePageDoctor> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            height: 900,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 160,
                  child: const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,

                    child: Icon(Icons.person,size: 80,color: Colors.green,),
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black,

                      width: 4.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                SizedBox(
                  width: size.width * .3,
                  child: Row(
                    children: [
                      Text(
                        'Louay elaroui'
                        ,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      //   SizedBox(
                      //       height: 16,
                      // child: Image.asset("images/verified.png")),
                    ],
                  ),
                ),
                Text(
                  'louayelaroui@gamil.com',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: size.height * .7,
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ProfileWidget(
                        icon: Icons.person,
                        title: 'My Profile',
                      ),
                      ProfileWidget(
                        icon: Icons.settings,
                        title: 'Settings',
                      ),
                      ProfileWidget(
                        icon: Icons.notifications,
                        title: 'Notifications',
                      ),
                      ProfileWidget(
                        icon: Icons.chat,
                        title: 'FAQs',
                      ),
                      ProfileWidget(
                        icon: Icons.share,
                        title: 'Share',
                      ),
                      ProfileWidget(
                        icon: Icons.logout,
                        title: 'Log Out',
                        onTap: () {
                          AuthRepo.logOut().then((value){
                            context.read<RouteModel>().changeRoute("/auth");
                            Navigator.of(context).pushNamedAndRemoveUntil("/", (route) => false);
                          }).onError((error, stackTrace) {
                            print(error);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
