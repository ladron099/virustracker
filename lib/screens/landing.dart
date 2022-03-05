import 'package:CovidTracker/resources/conn.dart';
import 'package:CovidTracker/screens/acceuil.dart';
import 'package:CovidTracker/screens/home.dart';
import 'package:CovidTracker/screens/maintenance.dart';
import 'package:CovidTracker/screens/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:CovidTracker/resources/logo.dart';
import 'package:CovidTracker/resources/background.dart';
import 'package:CovidTracker/resources/submitButton.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:CovidTracker/resources/color.dart';
import 'package:provider/provider.dart';
import '../DAL/utilisateur.dart';
import 'login.dart';

class landing extends StatefulWidget {
  const landing({Key? key}) : super(key: key);

  @override
  _landingState createState() => _landingState();
}

class _landingState extends State<landing> {
  @override
  bool active = false;

  _betch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('adminActions')
          .doc('maintenance')
          .get()
          .then((ds) {
        setState(() {
          active = ds.get('activated');
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    _betch();
    Widget wrapContent = Text('');
    if (!active) {
      wrapContent = Scaffold(
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
                background(path: "assets/images/landing.png"),
                Padding(
                  padding: EdgeInsets.only(top: h*0.050),
                  child: Container(
                    child: Text(
                      'Bienvenue.',
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                        fontSize: h*0.020,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    height: h*0.030,
                  ),
                ),
                Container(
                  child: FractionallySizedBox(
                    child: Text(
                      'Connectez vous ou créer un compte pour continuer.',
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w100,
                        fontSize: h*0.017,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    widthFactor: 0.72,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: h*0.070),
                  child: FractionallySizedBox(
                    child: submitButton(
                      text: "Connexion",
                      press: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => login()));
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
                FractionallySizedBox(
                  child: OutlineGradientButton(
                    child: GradientText(
                      'Créer un compte',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w100,
                      ),
                      textAlign: TextAlign.center,
                      colors: [ybcolor2, ybcolor],
                    ),
                    gradient: gradientcolor,
                    strokeWidth: 2,
                    radius: Radius.circular(25),
                    padding: EdgeInsets.symmetric(horizontal: h*0.024, vertical: h*0.017),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => register()));
                    },
                  ),
                  widthFactor: 0.77,
                ),
              ],
            ),
          )),
        ),
      );
    } else {
      wrapContent = maintenance();
    }
    final use = Provider.of<utilisateur?>(context);
    if (use == null)
      return SafeArea(
        child: conn(clas: wrapContent),
      );
    else
      return acceuilScreen();
  }
}
