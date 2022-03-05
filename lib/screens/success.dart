
import 'package:CovidTracker/resources/background.dart';
import 'package:CovidTracker/resources/conn.dart';
import 'package:CovidTracker/resources/infoText.dart';
import 'package:CovidTracker/resources/logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../resources/color.dart';
import 'landing.dart';
import 'login.dart';

class success extends StatefulWidget {
  const success({Key? key}) : super(key: key);

  @override
  _successState createState() => _successState();
}

class _successState extends State<success> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    Widget wrapContent=Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          splashRadius: 1,
          icon: Icon(
            Icons.chevron_left_rounded,
            size: h*0.040,
          ),
          onPressed: () =>  Navigator.push(context,
              MaterialPageRoute(builder: (context) => landing())),
          color: ybcolor,
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: h*0.050),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  logo()
                ],
              ),
            ),
            FractionallySizedBox(
              child: Padding(
                padding: EdgeInsets.only(top: h*0.030),
                child: Image.asset(
                  "assets/images/success.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
              widthFactor: 0.77,
            ),
            Padding(
              padding: EdgeInsets.only(top: h*0.030),
              child: Text(
                'Succés',
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontStyle: FontStyle.normal,
                  fontSize: h*0.019,
                  color: ybcolor,
                  fontWeight: FontWeight.bold
                )),
            ),
            Padding(
              padding: EdgeInsets.only(top: h*0.015, right: h*0.050, left: h*0.050),
              child:
              Text(
                  'Veuillez consulter votre email et suivez les étapes pour réinitialiser votre mot de passe...',
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontStyle: FontStyle.normal,
                    fontSize: h*0.017,
                    color: Colors.black,
                  ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
    return SafeArea(
      child: conn(clas: wrapContent,)
    );
  }
}
