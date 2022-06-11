import 'package:CovidTracker/resources/popups.dart';
import 'package:CovidTracker/screens/maintenance.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../utils/color.dart';
import '../resources/popups.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({Key? key}) : super(key: key);

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  bool active = false;
  bool _isObscure = true;

  TextEditingController previousPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    Widget wrapContent = Text('');
    if (!active) {
      wrapContent = Center(
        child: Scaffold(
             appBar: AppBar(
              centerTitle: true,
              title: Text(
                "Supprimer votre compte",
                style: TextStyle(
                  color: ybcolor,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                splashRadius: 1,
                icon: Icon(
                  Icons.chevron_left_rounded,
                  size: 40,
                ),
                onPressed: () => Navigator.pop(context),
                color: ybcolor,
              ),
            ),
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: h * 0.09,
            ),
            Padding(
                padding:
                    EdgeInsets.fromLTRB(h * 0.045, 0, h * 0.045, h * 0.045),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Quand vous supprimez votre compte, toutes vos données sur VIRUS TRACKER seront supprimés.",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w100,
                          fontSize: h * 0.015,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ])),
            SizedBox(height: h * 0.012),
            Padding(
              padding: EdgeInsets.all(h * 0.035),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          h * 0.06, h * 0.020, h * 0.05, h * 0.015),
                      child: Text(
                        'Entrez votre mot de passe actuel',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: ybcolor,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          h * 0.020, h * 0.010, h * 0.020, h * 0.030),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: ybcolor.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(h * 0.010),
                          child: TextFormField(
                            controller: previousPassword,
                            obscureText: _isObscure,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: Colors.grey[700],
                              fontSize: 16,
                            ),
                            cursorColor: ybcolor,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: ybcolor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                },
                                padding: EdgeInsets.only(bottom: 0),
                              ),
                              contentPadding: EdgeInsets.fromLTRB(
                                  h * 0.01, h * 0.0, h * 0.020, h * 0.020),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(h * 0.030),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: h * 0.18,
                    decoration: BoxDecoration(
                      color: Color(0XFFD16868),
                      borderRadius: new BorderRadius.circular(50.0),
                    ),
                    child: MaterialButton(
                        highlightColor: Colors.red,
                        shape: StadiumBorder(),
                        textColor: Colors.white,
                        child: Text(
                          'Continuer',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        onPressed: () async {  final ConnectivityResult result = await Connectivity().checkConnectivity();

                        if(result!=ConnectivityResult.none){
                          print('a;sdlf;sdfj ${previousPassword.text} ');
                            final prefs = await SharedPreferences.getInstance();
                            String token =prefs.getString('token')??'';
                              String password = prefs.getString('password')??'';
                              print(password);
                              bool isPassword=false;
                              if(password==previousPassword.text){
                               setState(() {
                                 isPassword=true;
                               });
                              }
                              else{
                               setState(() { isPassword=false; });
                              }
                           
                            isPassword? showDeletePopup(context, token):    Fluttertoast.showToast(
                          msg: 'Mot de passe incorrect',
                        toastLength: Toast.LENGTH_LONG,
                       gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 2,
                         backgroundColor: danger,
                        textColor: Colors.white,
                            fontSize: 15);
                      } else{
                             setState(() {
                             Fluttertoast.showToast(
          msg: 'Une erreur est survenue. Veuillez verifiez votre connexion internet et réssayer.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: danger,
          textColor: Colors.white,
          fontSize: 15);
                          });

                      }}),
                  ),
                  SizedBox(
                    width: h * 0.18,
                    child: OutlineGradientButton(
                      child: GradientText(
                        'Annuler',
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
                      padding: EdgeInsets.symmetric(
                          horizontal: h * 0.024, vertical: h * 0.017),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'Copyright © VIRUS TRACKER 2021-2022',
                style: TextStyle(
                  color: Colors.grey.withOpacity(0.3),
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
            SizedBox(height: h * 0.02)
          ],
        )),
      );
    } else
      wrapContent = maintenance();
    return SafeArea(child:  wrapContent);
  }
}
