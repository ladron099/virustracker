import 'dart:io';

import 'package:CovidTracker/screens/acceuil.dart';
import 'package:CovidTracker/screens/wrapper.dart';
import 'package:CovidTracker/widgets/connection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:CovidTracker/resources/logo.dart';
import 'package:CovidTracker/resources/background.dart';
import 'package:CovidTracker/resources/submitButton.dart';
import 'package:CovidTracker/resources/color.dart';
import 'package:provider/provider.dart';
import '../DAL/utilisateur.dart';
import '../resources/loading.dart';

class maintenance extends StatefulWidget {
  const maintenance({Key? key}) : super(key: key);

  @override
  _maintenanceState createState() => _maintenanceState();
}

class _maintenanceState extends State<maintenance> {
  String msg="";
  _betch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('adminActions')
          .doc('maintenance')
          .get()
          .then((ds) {
        setState(() {
          msg = ds.get('message');
        });
      });
    }
  }
  connection a=connection();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    _betch();
    if (loading)
      return Loading();
    else
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      logo(),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: FractionallySizedBox(
                          child: Text(
                            '$msg',
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w100,
                              fontSize: 17,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          widthFactor: 0.72,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      background(path: "assets/images/offline.png"),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: FractionallySizedBox(
                          child: Text(
                            'Veuillez attendre quelques minutes',
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w100,
                              fontSize: 17,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          widthFactor: 0.72,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )),
          ),
        ),
      );
  }
}
