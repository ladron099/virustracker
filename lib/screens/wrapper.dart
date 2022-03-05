


import 'package:CovidTracker/DAL/utilisateur.dart';
import 'package:CovidTracker/screens/bienvenue.dart';
import 'package:CovidTracker/screens/acceuil.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../DAL/authService.dart';
import '../DAL/user.dart';
import 'home.dart';

class wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    try {
      final use = Provider.of<utilisateur?>(context);
      if (use == null) {
        return bienvenue();

      } else {
        return acceuilScreen();
      }
    }
    catch(e){
      print(e.toString());
      return bienvenue();
    }
  }
}