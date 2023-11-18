import 'package:shared_preferences/shared_preferences.dart';
import 'package:embs/helper/http_client.dart';

class AuthRepo {
  static final endPoints = {
    "sigIn": "/api/auth/signin",
    "sigUp": "/api/auth/signup",
    "logout": "/api/auth/logout",

  };

  static Future<void> signIn({required String username, required String password}) async {
    var value = await HttpClient.post(endPoint: endPoints["sigIn"], body: {"username": username, "password": password});
    var pref = await SharedPreferences.getInstance();

    // Store the JWT token
    await pref.setString("token", value["access_token"]);

    if (value.containsKey("role")) {
      await pref.setString("role", value["role"]);
    }
  }

  static Future<void> logOut() async {
    var pref = await SharedPreferences.getInstance();
    await pref.remove("token");
    await pref.remove("role");
  }


}