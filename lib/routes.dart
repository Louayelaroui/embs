
import 'package:embs/pages/Index%20Page/index_page.dart';
import 'package:embs/pages/User%20View/User_Page.dart';
import 'package:embs/pages/auth/SignIn.dart';
import 'package:embs/pages/auth/Welcome.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes = {
  "/": (context)=>const IndexPage(),
  "/auth": (context)=> const SignIn(),
  "/welcome": (context)=> const Welcome(),
  "/UserPage": (context)=> const UserPage(),
};