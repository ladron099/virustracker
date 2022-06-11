import 'dart:math';
import 'package:CovidTracker/utils/color.dart';
import 'package:CovidTracker/screens/bienvenue.dart';
import 'package:CovidTracker/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = await preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
 
  static final String oneSignalAppId = "f77b95c9-b3c5-4174-bdc7-15ef7c959728";
  


 Future<void> initOneSignal(BuildContext context) async { 
    await OneSignal.shared.setAppId(oneSignalAppId); 
      String osUserID='userID';
        SharedPreferences preferences = await SharedPreferences.getInstance();
    OneSignal.shared.setSubscriptionObserver((changes)   { print('dhfakfjas;'+'${changes.to.userId}');
      osUserID = changes.to.userId??'';
      print('sdfghjkl'+osUserID); 
      

  String playerid=osUserID;
  
    preferences.setString('fcm','$playerid');

    });
      await OneSignal.shared.promptUserForPushNotificationPermission(
      fallbackToSettings: true,
    );

 OneSignal.shared.setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent event) {
  // Will be called whenever a notification is received in foreground
  // Display Notification, pass null param for not displaying the notification
        event.complete(event.notification);                                 
});
OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult result) {
 print('notif pressed');
});
OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
    print('huh');
});
    final status = await OneSignal.shared.getDeviceState();
   

 

  }
  
@override
  void initState() {
    super.initState();
    initOneSignal(context);
  }


  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        primaryColor: ybcolor,
        splashColor: ybcolor,
        fontFamily: 'Montserrat',
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: initScreen== 0 || initScreen==null ? 'onboard' : 'home',
      routes: {
        'home': (context) => wrapper(),
        'onboard': (context) => bienvenue(),
      },
    );
  }
}