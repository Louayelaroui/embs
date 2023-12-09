import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../reposetories/auth_repository.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  final formKey = GlobalKey<FormState>();
  bool invalid = false;
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
                child: Form(
                  key:formKey,
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
                            title: 'Email'.tr(),
                            hintTextKey: 'Enter_Your_email'.tr(),
                            inputColor: Colors.blue,
                            hintColor: Colors.grey,
                            validator: (value){
                              if(value !=null && value.length< 3){
                                return "please_enter_a_valid_email".tr();
                              }
                              return null;
                            },
                          ),
                          CustomInputField(
                            controller: passwordController,
                            title: 'Password'.tr(),
                            hintTextKey: 'Enter_Your_password'.tr(),
                            inputColor: Colors.blue,
                            hintColor: Colors.grey,
                            obscureText: true,
                              validator: (value){
                                if(value !=null && value.length< 3){
                                  return "please_enter_a_valid_password".tr();
                                }
                                return null;
                              }
                          ),
                          CustomBtn(
                            text: 'SignIn',
                            onPress: () {

                              if(formKey.currentState!.validate()) {
                                AuthRepo.signIn(
                                    password: passwordController.text, email: emailController.text).then((value){

                                  Navigator.of(context).pushNamedAndRemoveUntil("/UserPage", (predicate) => false);
                                }).onError((error, stackTrace){
                                  print(error);
                                  formKey.currentState!.validate();
                                  setState(() {
                                    invalid = true;
                                  });
                                });
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
          ),
        ],
      ),
    );
  }


}
