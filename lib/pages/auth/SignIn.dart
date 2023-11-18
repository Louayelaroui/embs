import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/route.dart';
import '../../reposetories/auth_repository.dart';
import '../components/custom_btn.dart';
import '../components/custom_input_field.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  SignInBody(),
    );
  }
}

class SignInBody extends StatefulWidget {
  const SignInBody({Key? key}) : super(key: key);

  @override
  State<SignInBody> createState() => _SignInBodyState();
}

class _SignInBodyState extends State<SignInBody> {

  late TextEditingController usernameController;
  late TextEditingController passwordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  final formKey = GlobalKey<FormState>();

  bool invalid = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text("to_use", style: textTheme.displaySmall,).tr(),

                  const SizedBox(height: 20,),

                  CustomInputField(title: "email".tr(),
                    controller: usernameController,
                    validator: (value){
                      if(value !=null && value.length< 3){
                        return "please_enter_a_valid_Team_name".tr();
                      }
                      return null;
                    },),
                  const SizedBox(height: 20,),
                  CustomInputField(title: "TeamPass".tr(), obscureText: true,
                      controller: passwordController,
                      validator: (value){
                        if(value !=null && value.length< 3){
                          return "please_enter_a_valid_password".tr();
                        }

                        return null;
                      }    ),
                ],
              ),
            ),
            if(invalid)
              Column(
                children: [
                  const SizedBox(height: 20,),
                  Text("invalid_credentials".tr(), style: textTheme.displayMedium?.copyWith(color: Colors.redAccent, fontWeight: FontWeight.bold),),
                ],
              ),
            const SizedBox(height: 20,),

            CustomBtn(text: "Send".tr(), onPress: () {
              if(formKey.currentState!.validate()) {
                AuthRepo.signIn(username: usernameController.text, password: passwordController.text).then((value){
                  context.read<RouteModel>().changeRoute("/roles");
                  /*Navigator.of(context).pushNamedAndRemoveUntil("/roles", (predicate) => false);*/
                }).onError((error, stackTrace){
                  print(error);
                  formKey.currentState!.validate();
                  setState(() {
                    invalid = true;
                  });
                });
              }
            },),

          ],
        ),
      ),
    );
  }
}