import 'package:flutter/material.dart';
import '../../reposetories/constants.dart';
import '../components/custom_btn.dart';
import '../components/custom_input_field.dart';
import '../components/header.dart';


class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Positioned.fill(
            child: Header(),
          ),

          Positioned.fill(
            top: MediaQuery.of(context).padding.top + 10,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'SignIn',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 40),

                  Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: Image.asset(
                              'assets/images/SignIn.png',
                              height: 75,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          CustomInputField(
                            title: 'Email',
                            hintTextKey: 'enter your email',
                            inputColor: Colors.blue,
                            hintColor: Colors.grey,

                          ),

                          CustomInputField(
                            title: 'Password',
                            hintTextKey: 'enter your password',
                            inputColor: Colors.blue,
                            hintColor: Colors.grey,
                            obscureText: true,

                          ),

                          CustomBtn(
                            text: 'SignIn',
                            onPress: () { },
                            primary: true,
                            textColors: Colors.white,
                            buttonColor: SignInColor,
                          ),
                        ],
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
