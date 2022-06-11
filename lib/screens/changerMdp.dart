
import 'dart:convert';
import 'package:CovidTracker/services/apiServices/apiFunctions.dart';
import 'package:CovidTracker/utils/loading.dart';
import 'package:CovidTracker/screens/acceuil.dart';
import 'package:CovidTracker/screens/maintenance.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../utils/color.dart';



class changerMdp extends StatefulWidget {
  String token;
  String email;
   changerMdp(this.token,this.email) ;

  @override
  State<changerMdp> createState() => _changerMdpState(token,email);
}

class _changerMdpState extends State<changerMdp> {
  TextEditingController previousPassword = TextEditingController();
  TextEditingController newPassword1 = TextEditingController();
  TextEditingController newPassword = TextEditingController();

  bool _isObscure = true;
  bool _isObscure1 = true;
  bool _isObscure2 = true;
bool active = false;
String token;
String email;
bool loading=false;

  _changerMdpState(this.token, this.email);

  String error='';

  @override
  Widget build(BuildContext context) {

    double h = MediaQuery.of(context).size.height;
    Widget wrapContent=Text('');
    if(!active)
      wrapContent=Center(
          child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  "Changer votre mot de passe",
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
                    Icons.close,
                  ),
                  onPressed: () => Navigator.pop(context),
                  color: ybcolor,
                ),
              ),
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(h*0.050,h*0.020,h*0.050,h*0.050),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              text: 'Pour protéger vos données et votre compte, votre nouveau mot de passe doit: \n',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Montserrat',
                                    fontSize: h*0.015
                                ),
                              children: <TextSpan>[
                                TextSpan(text: '\n• Avoir au moins 8 caractéres'),
                                TextSpan(text: '\n• Avoir au moins une lettre majuscule'),
                                TextSpan(text: '\n• Avoir au moins une lettre miniscule'),
                                TextSpan(text: '\n• Avoir un nombre ou un symbole ( + - ! etc..)'),
                              ],
                            ),
                        ),
                          ),
                      ])
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(h*0.040,0,h*0.040,0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
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
                                  padding: EdgeInsets.fromLTRB(h*0.030, h*0.020, h*0.020, 0),
                                  child: Text(
                                    'Entrez votre mot de passe actuel',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: ybcolor,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize:13,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(h*0.020, h*0.010, h*0.020, h*0.0),
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
                                      padding: EdgeInsets.all(h*0.010),
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
                                              _isObscure ? Icons.visibility : Icons.visibility_off,
                                              color: ybcolor,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _isObscure = !_isObscure;
                                              });
                                            },
                                            padding: EdgeInsets.only(bottom:0),
                                          ),
                                          contentPadding: EdgeInsets.fromLTRB(h*0.01, h*0.0, h*0.020, h*0.020),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                /////////----------------------END OF FIRST INPUT----------/////////
                                Padding(
                                  padding: EdgeInsets.fromLTRB(h*0.030, h*0.020, h*0.020, 0),
                                  child: Text(
                                    'Entrez votre nouveau mot de passe',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: ybcolor,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize:13,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(h*0.020, h*0.010, h*0.020,0),
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
                                      padding: EdgeInsets.all(h*0.010),
                                      child: TextFormField(
                                        obscureText: _isObscure1,
                                        controller: newPassword1,
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Colors.grey[700],
                                          fontSize: 16,
                                        ),
                                        cursorColor: ybcolor,
                                        decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _isObscure1 ? Icons.visibility : Icons.visibility_off,
                                              color: ybcolor,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _isObscure1 = !_isObscure1;
                                              });
                                            },
                                            padding: EdgeInsets.only(bottom:0),
                                          ),
                                          contentPadding: EdgeInsets.fromLTRB(h*0.01, h*0.0, h*0.020, h*0.020),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                /////////----------------------END OF SECOND INPUT----------/////////
                                Padding(
                                  padding: EdgeInsets.fromLTRB(h*0.030, h*0.020, h*0.020, 0),
                                  child: Text(
                                    'Confirmez votre mot de passe',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: ybcolor,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      fontSize:13,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(h*0.020, h*0.010, h*0.020, h*0.030),
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
                                      padding: EdgeInsets.all(h*0.010),
                                      child: TextFormField(
                                        controller: newPassword,
                                        obscureText: _isObscure2,
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          color: Colors.grey[700],
                                          fontSize: 16,
                                        ),
                                        cursorColor: ybcolor,
                                        decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _isObscure2 ? Icons.visibility : Icons.visibility_off,
                                              color: ybcolor,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _isObscure2 = !_isObscure2;
                                              });
                                            },
                                            padding: EdgeInsets.only(bottom:0),
                                          ),
                                          contentPadding: EdgeInsets.fromLTRB(h*0.01, h*0.0, h*0.020, h*0.020),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                   Container(
                     margin: EdgeInsets.symmetric(horizontal: h*0.05, vertical: h*0.02),
                    child: Padding(
                      padding:  EdgeInsets.all(0),
                      child: Text(error,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                   ),
                    Padding(padding: EdgeInsets.all(h*0.030),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              gradient: gradientcolor,
                              borderRadius: new BorderRadius.circular(50.0),
                            ),
                            child: MaterialButton(
                              highlightColor: ybcolor,
                              shape: StadiumBorder(),
                              textColor: Colors.white,
                              child: Text('Enregistrer',
                                style:
                                TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                              onPressed: () async {  final ConnectivityResult result = await Connectivity().checkConnectivity();

                        if(result!=ConnectivityResult.none){
                                setState(() {
                                  loading=true;
                                });
                             ApiFunctions passChange=ApiFunctions();
                             if(newPassword1.text==newPassword.text ) {
                               var aa = await passChange.modifyPassword(
                                   token, email, previousPassword.text,
                                   newPassword.text);
                                   print('${aa.statusCode}');
                               if(aa.statusCode==200){
                                 setState(() {
                                   loading=false;
                                   error='';
                                 });
                                 final prefs = await SharedPreferences.getInstance();
                                 bool startService = await prefs.getBool('startService') ?? false;
                                 await prefs.setString('password', newPassword.text);
                                 print(newPassword.text);
                                 String b = await prefs.getString('password') ?? 'no';
                                 print(b);
                                 Navigator.push(context,
                                     MaterialPageRoute(builder: (context) => acceuilScreen('', startService)));
                                 Fluttertoast.showToast(
                                     msg: 'Votre mot de passe a été modifié avec succés',
                                     toastLength: Toast.LENGTH_LONG,
                                     gravity: ToastGravity.BOTTOM,
                                     timeInSecForIosWeb: 2,
                                     backgroundColor: Colors.green,
                                     textColor: Colors.white,
                                     fontSize: 15);
                               }
                               else{
                                 setState(() {
                                   loading=false;
                                   final Map<String, dynamic> data = json.decode(aa.body);
                                   print(data['msg']);
                                   print('${aa.statusCode}');
                                   error=data['msg'];
                                 });
                               }
                             }else{
                              setState(() {
                                loading=false;
                                error='Les mots de passes sont différents.';
                              });
                             }}
                             else{
                                  setState(() {
                            loading=false;
                             Fluttertoast.showToast(
          msg: 'Une erreur est survenue. Veuillez verifiez votre connexion internet et réssayer.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: danger,
          textColor: Colors.white,
          fontSize: 15);
                          });
                             }
                              },
                            ),
                          ),
                          OutlineGradientButton(
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
                            padding: EdgeInsets.symmetric(horizontal: h*0.024, vertical: h*0.017),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(h*0.050),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'Copyright © VIRUS TRACKER 2021-2022',
                          style: TextStyle(
                            color: Colors.grey.withOpacity(0.3),
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize:10,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
          ));
    else wrapContent=maintenance();
      return loading ? Loading():SafeArea(child: wrapContent);
  }
  }

