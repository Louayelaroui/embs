import 'package:embs/pages/auth/SignIn.dart';
import 'package:embs/pages/auth/Welcome.dart';
import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';

import '../../models/route.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RouteModel>(
      builder: (context, route, child){
        return  Welcome();
        // if(route.route == "/user"){
        //    return const doctor();
        // }
        // if(route.route == "/doctor"){
        //    return const user();
        // }
        // else{
        //   return const SignIn();
        // }
      },
    );
  }
}