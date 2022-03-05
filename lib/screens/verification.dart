
import 'package:CovidTracker/resources/background.dart';
import 'package:CovidTracker/resources/color.dart';
import 'package:CovidTracker/resources/conn.dart';
import 'package:CovidTracker/resources/errorMessage.dart';
import 'package:CovidTracker/resources/infoText.dart';
import 'package:CovidTracker/resources/loading.dart';
import 'package:CovidTracker/resources/logo.dart';
import 'package:CovidTracker/resources/submitButton.dart';
import 'package:CovidTracker/screens/success.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../DAL/authService.dart';
import 'landing.dart';
import 'login.dart';

class verification extends StatefulWidget {
  const verification({Key? key}) : super(key: key);

  @override
  _verificationState createState() => _verificationState();
}

class _verificationState extends State<verification> {
  final AuthService _auth = AuthService();
  bool _isObscure = true;
  String email = '';
  bool loading = false;
  String error = '';

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    Widget wrapContent=Center(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left_rounded,
              size: h*0.040,
            ),
            onPressed: () => Navigator.pop(context),
            color: ybcolor,
          ),
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              if (!isKeyboard)
                background(path: "assets/images/verifier.png"),
              if (!isKeyboard)
                Padding(padding: EdgeInsets.only(top: h*0.020)),
              if (!isKeyboard)
                infoText(
                  text: "Réinitialisation du mot de passe",
                  size: h*0.017,
                ),
              SizedBox(
                height: h*0.100,
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(h*0.035, h*0.030, h*0.035, 0),
                    child: TextField(
                      onChanged: (val) {
                        email = val;
                      },
                      textAlign: TextAlign.center,
                      autocorrect: true,
                      decoration: InputDecoration(
                        hintText: 'Entrez votre email',
                        contentPadding:
                        EdgeInsets.only(top: h*0.002, left: h*0.040),
                        filled: true,
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: ybcolor,
                        ),
                        hintStyle: TextStyle(
                            fontSize: h*0.015,
                            fontFamily: 'Montserrat',
                            color: Colors.grey[400]),
                        fillColor: Colors.white70,
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(50.0)),
                          borderSide:
                          BorderSide(color: ybcolor, width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(50.0)),
                          borderSide:
                          BorderSide(color: ybcolor, width: 2),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: h*0.015)),
              FractionallySizedBox(
                widthFactor: 0.84,
                child: submitButton(
                  text: "Envoyer",
                  press: () async {
                    setState(() {
                      loading = true;
                    });
                    var a = await _auth.resetPassword(email);
                    if (a == null) {
                      setState(() {
                        loading = false;
                        error =
                        'Aucun compte n\'est inscrit avec cet email!';
                      });
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => success()));
                    }
                  },
                  color: ybcolor,
                  textColor: Colors.white,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(child: errorMessage(error)),
            ],
          ),
        ),
      ),
    );
    return loading
        ? Loading()
        : SafeArea(
            child: conn(clas: wrapContent)
          );
  }
}
