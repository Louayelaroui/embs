
import 'dart:convert';

import 'package:flutter/foundation.dart';

class User extends ChangeNotifier {
  int? id;
  String? name;
  String? email;
  String? password;
  double? weight;
  double? height;
  String? cin;
  String? telephone;
  String? specialRequirements;
  String? role;
  DateTime? lastLogin;

  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.weight,
    this.height,
    this.cin,
    this.telephone,
    this.specialRequirements,
    this.role,
    this.lastLogin,
  });
   factory User.fromJson(Map<String, dynamic> json) {
  return User(
  id: json["id"] as int?,
  name: json["name"] as String?,
  email: json["email"] as String?,
  password: json["password"] as String?,
  weight: (json["weight"] as num?)?.toDouble(), // Handle nullable and convert to double
  height: (json["height"] as num?)?.toDouble(), // Handle nullable and convert to double
  cin: json["cin"] as String?,
  telephone: json["telephone"] as String?,
  specialRequirements: json["special_requirements"] as String?,
  role: json["role"] as String?,
  lastLogin: json["last_login"] != null
  ? DateTime.parse(json["last_login"] as String)
      : null,
  );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "password": password,
    "weight": weight,
    "height": height,
    "cin": cin,
    "telephone": telephone,
    "special_requirements": specialRequirements,
    "role": role,
    "last_login": lastLogin?.toIso8601String(),
  };
}
class Users extends ChangeNotifier {
  List<User> users = [];

  Users(this.users);

  Users.fromJson(List<dynamic> json) {
    users = json.map((e) => User.fromJson(e)).toList();
    notifyListeners();
  }

  List<dynamic> toJson() {
    return users.map((e) => e.toJson()).toList();
  }

  setUsers(List<User> userList) {
    users = userList;
    notifyListeners();
  }

  addUser(User user) {
    users.add(user);
    notifyListeners();
  }

  updateUser(String id, User user) {
    users = users.map((e) {
      if (e.id == id) {
        return user;
      }
      return e;
    }).toList();

    notifyListeners();
  }

  deleteUser(String id) {
    users = users.where((element) => element.id != id).toList();
    notifyListeners();
  }
}
