import 'package:CovidTracker/services/apiServices/apiFunctions.dart';
import 'package:CovidTracker/utils/loading.dart';
import 'package:CovidTracker/screens/acceuil.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'landing.dart';

class wrapper extends StatefulWidget {
  @override
  State<wrapper> createState() => _wrapperState();
}

class _wrapperState extends State<wrapper> {
  String token = '';

  Widget loggedIn= Loading();

  ApiFunctions apiCheck = ApiFunctions();
  getusername() async {  
     final prefs = await SharedPreferences.getInstance();
        bool startService = await prefs.getBool('startService') ?? false;
     
     
    final ConnectivityResult result = await Connectivity().checkConnectivity();

                        if(result!=ConnectivityResult.none){
   
    token = (prefs.getString('token') ?? '');
 
    var e=await apiCheck.getuser(token);
    print(e.statusCode);
    if(e.statusCode==200){
      setState(() {
        loggedIn=acceuilScreen('',startService);
      });
    }
    else{
    setState(() {
      loggedIn= landing();
    });
    }
    }
    else{
      token = (prefs.getString('token') ?? '');
      if(token.isNotEmpty){
        setState(() {
        loggedIn=acceuilScreen('',startService);
      });
      }  else{
    setState(() {
      loggedIn= landing();
    });
    }
    }

  }

  @override
  void initState() {
    super.initState();
    getusername();
  }

  @override
  Widget build(BuildContext context) {

   return loggedIn;

  }
}