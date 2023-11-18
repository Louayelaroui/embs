import 'package:flutter/material.dart';

class RouteModel extends ChangeNotifier{
  String route = "/";

  RouteModel(this.route);

  changeRoute(String route){
    this.route = route;
    notifyListeners();
  }
}