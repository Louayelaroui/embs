import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../reposetories/constants.dart';
import '../components/custom_btn.dart';
import '../components/custom_input_field.dart';
import '../components/header.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();

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
                      'SignUp',
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
                          controller: nameController,
                          title: 'Name',
                          hintTextKey: 'enter your name',
                          inputColor: Colors.blue,
                          hintColor: Colors.grey,
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
                        CustomInputField(
                          controller: repeatPasswordController,
                          title: 'Repeat Password',
                          hintTextKey: 'Repeat Password',
                          inputColor: Colors.blue,
                          hintColor: Colors.grey,
                          obscureText: true,
                        ),
                        CustomBtn(
                          text: 'SignUp',
                          onPress: () {
                            signUpUser();
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

  Future<void> signUpUser() async {
    final url = 'the api endpoint';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'name': nameController.text,
          'email': emailController.text,
          'password': passwordController.text,
        },
      );

      if (response.statusCode == 200) {

        print('User signed up successfully!');

      } else {

        print('Error: ${response.statusCode}');
        print('Body: ${response.body}');

      }
    } catch (error) {

      print('Error: $error');

    }
  }
}
