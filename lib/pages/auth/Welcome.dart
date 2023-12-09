import 'package:flutter/material.dart';
import '../../reposetories/constants.dart';
import '../View/Doctor/UserList/UsersList.dart';
import '../View/User_Page.dart';
import '../components/custom_btn.dart';
import '../components/header.dart';
import 'SignIn.dart';
import 'SignUp.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Header(),
          ),

          Positioned.fill(
            top: MediaQuery.of(context).padding.top + 20,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 150),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Image.asset(
                              'assets/images/home.jpg',
                              height: 300,
                              width: 300,
                              fit: BoxFit.cover,
                            ),
                          ),
                          CustomBtn(
                            text: 'SignUp',
                            onPress: () {
                              Navigator.push(context,
                                MaterialPageRoute(builder:
                                    (context) => const
                                    SignUp(),
                                ),);
                            },
                            primary: true,
                            textColors: Colors.white,
                            buttonColor: SignUpColor,
                          ),
                          SizedBox(height: 20),
                          CustomBtn(
                            text: 'SignIn',
                            onPress: () { Navigator.push(context,
                              MaterialPageRoute(builder:
                                  (context) => SignIn()
                                    //SignIn(),
                              ),);},
                            primary: true,
                            textColors: Colors.white,
                            buttonColor: SignInColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
