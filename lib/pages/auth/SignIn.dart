import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../reposetories/constants.dart';
import '../components/custom_btn.dart';
import '../components/custom_input_field.dart';
import '../components/header.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
              child: SingleChildScrollView(
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
                    Column(
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
                          controller: emailController,
                          title: 'Email',
                          hintTextKey: 'enter your email',
                          inputColor: Colors.blue,
                          hintColor: Colors.grey,
                        ),
                        CustomInputField(
                          controller: passwordController,
                          title: 'Password',
                          hintTextKey: 'enter your password',
                          inputColor: Colors.blue,
                          hintColor: Colors.grey,
                          obscureText: true,
                        ),
                        CustomBtn(
                          text: 'SignIn',
                          onPress: () {
                            signInUser();
                          },
                          primary: true,
                          textColors: Colors.white,
                          buttonColor: SignInColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> signInUser() async {
    final url = 'the api endpoint';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'email': emailController.text,
          'password': passwordController.text,
        },
      );

      if (response.statusCode == 200) {

        print('User signed in successfully!');

      } else {

        print('Error: ${response.statusCode}');
        print('Body: ${response.body}');

      }
    } catch (error) {

      print('Error: $error');

    }
  }
}
