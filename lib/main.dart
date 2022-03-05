import 'package:CovidTracker/DAL/utilisateur.dart';
import 'package:CovidTracker/resources/color.dart';
import 'package:CovidTracker/resources/conn.dart';
import 'package:CovidTracker/screens/bienvenue.dart';
import 'package:CovidTracker/screens/landing.dart';
import 'package:CovidTracker/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'DAL/authService.dart';

int? initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = await preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  await Firebase.initializeApp(); runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<utilisateur?>.value(
      value: AuthService().user,
      initialData: null,
      catchError: (_, __) => null,
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: ybcolor,
          fontFamily: 'Montserrat',
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: initScreen== 0 || initScreen==null ? 'onboard' : 'home',
        routes: {
          'home': (context) => conn( clas:landing()),
          'onboard': (context) =>conn(clas: wrapper()),
        },
      ),
    );
  }
}
