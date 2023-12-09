import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../models/User.dart';
import '../../reposetories/auth_repository.dart';
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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController cinController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();
  TextEditingController specialRequirementsController = TextEditingController();

  String selectedRole = 'user'; // Default role is 'user'
@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
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
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
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
                                validator: (value) {
                                  if (value != null && value.length < 3) {
                                    return "please_enter_a_valid_password".tr();
                                  }
                                  return null;
                                },
                              ),
                              CustomInputField(
                                controller: repeatPasswordController,
                                title: 'Repeat Password',
                                hintTextKey: 'Repeat Password',
                                inputColor: Colors.blue,
                                hintColor: Colors.grey,
                                obscureText: true,
                                validator: (value) {
                                  if (value != null &&
                                      value.length < 3 &&
                                      value != passwordController.text) {
                                    return "please_enter_a_valid_password".tr();
                                  }
                                  return null;
                                },
                              ),
                              CustomInputField(
                                controller: weightController,
                                title: 'Weight',
                                hintTextKey: 'Enter your weight',
                                inputColor: Colors.blue,
                                hintColor: Colors.grey,
                              ),
                              CustomInputField(
                                controller: heightController,
                                title: 'Height',
                                hintTextKey: 'Enter your height',
                                inputColor: Colors.blue,
                                hintColor: Colors.grey,
                              ),
                              CustomInputField(
                                controller: cinController,
                                title: 'CIN',
                                hintTextKey: 'Enter your CIN',
                                inputColor: Colors.blue,
                                hintColor: Colors.grey,
                              ),
                              CustomInputField(
                                controller: telephoneController,
                                title: 'Telephone',
                                hintTextKey: 'Enter your telephone',
                                inputColor: Colors.blue,
                                hintColor: Colors.grey,
                              ),
                              CustomInputField(
                                controller: specialRequirementsController,
                                title: 'Special Requirements',
                                hintTextKey: 'Enter your special requirements',
                                inputColor: Colors.blue,
                                hintColor: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Radio(
                              value: 'user',
                              groupValue: selectedRole,
                              onChanged: (value) {
                                setState(() {
                                  selectedRole = value.toString();
                                });
                              },
                            ),
                            Text('User'),
                            Radio(
                              value: 'root',
                              groupValue: selectedRole,
                              onChanged: (value) {
                                setState(() {
                                  selectedRole = value.toString();
                                });
                              },
                            ),
                            Text('Doctor'),
                          ],

                        ),
                        CustomBtn(
                          text: 'SignUp',
                          onPress: () async {
                            if (formKey.currentState!.validate()) {
                              try {
                             await AuthRepo.signUp(
                                  role: selectedRole,
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  weight: double.parse(weightController.text),
                                  height: double.parse(heightController.text),
                                  cin: cinController.text ,
                                  telephone: telephoneController.text,
                                  specialRequirements: specialRequirementsController.text,
                                ).then((value) {
                                  context.read<Users>().addUser(value);
                                  Navigator.pop(context);

                             }
                             );

                                // Add the user to the provider

                              } catch (error) {
                                // Handle the error (e.g., show a snackbar)
                                print("Error during SignUp: $error");
                              }
                            }
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
}
