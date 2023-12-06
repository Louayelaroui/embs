import 'package:easy_localization/easy_localization.dart';
import 'package:embs/reposetories/constants.dart';
import 'package:embs/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/User.dart';
import 'models/route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  var pref = await SharedPreferences.getInstance();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<RouteModel>(create: (context)=>RouteModel(pref.containsKey("token")?"/roles":"/auth")),
      ChangeNotifierProvider<User>(create: (context)=>User()),
      ChangeNotifierProvider<Users>(create: (context) => Users([])),


    ],

    child: EasyLocalization(

        supportedLocales: const [

          Locale('fr'),
        ],
        path: 'assets/translations',
        child: const MyApp()
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) {
          return MaterialApp(
            title: 'physio',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch: Colors.grey,
                floatingActionButtonTheme: const FloatingActionButtonThemeData(
                    backgroundColor: scaffoldBackgroundColor,
                    foregroundColor: Colors.white
                ),
                appBarTheme: const AppBarTheme(
                    foregroundColor: Colors.white,
                    backgroundColor: scaffoldBackgroundColor
                ),
                scaffoldBackgroundColor: scaffoldBackgroundColor,
                textTheme: const TextTheme(
                    displayLarge: TextStyle(color: Colors.white, fontSize: 18),
                    displayMedium: TextStyle(color: Colors.white, fontSize: 16),
                    displaySmall: TextStyle(color: Colors.white, fontSize: 14)
                )
            ),
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            initialRoute: '/',
            routes: routes,
          );
        }
    );
  }
}