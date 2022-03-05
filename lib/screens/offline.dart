import 'dart:io';

import 'package:CovidTracker/screens/acceuil.dart';
import 'package:CovidTracker/screens/wrapper.dart';
import 'package:CovidTracker/widgets/connection.dart';
import 'package:flutter/material.dart';
import 'package:CovidTracker/resources/logo.dart';
import 'package:CovidTracker/resources/background.dart';
import 'package:CovidTracker/resources/submitButton.dart';
import 'package:CovidTracker/resources/color.dart';
import 'package:provider/provider.dart';
import '../DAL/utilisateur.dart';
import '../resources/loading.dart';

class offline extends StatefulWidget {
  const offline({Key? key}) : super(key: key);

  @override
  _offlineState createState() => _offlineState();
}

class _offlineState extends State<offline> {

connection a=connection();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
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
                    height: h*0.020,
                  ),
                  background(path: "assets/images/offline.png"),
                  SizedBox(
                    height: h*0.040,
                  ),
                  Container(
                    child: FractionallySizedBox(
                      child: Text(
                        'Veuillez vérifier que vous étes connectés a Internet et réessayer',
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w100,
                          fontSize: h*0.018,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      widthFactor: 0.72,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: h*0.040),
                    child: FractionallySizedBox(
                      child: submitButton(
                        text: "Réessayer",
                        press: () async {
                          setState(() {
                            loading = true;
                          });
                          bool bb = false;
                          bool aa = await a.internetcheck(bb);
                          if (aa == true)
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => wrapper()));
                          else {
                            setState(() {
                              loading = false;
                            });
                          }
                        },
                        color: ybcolor,
                        textColor: Colors.white,
                      ),
                      widthFactor: 0.77,
                    ),
                  ),
                  SizedBox(
                    height: h*0.020,
                  ),
                ],
              ),
            )),
          ),
        ),
      );
  }
}
