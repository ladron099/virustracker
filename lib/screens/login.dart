import 'dart:convert';
import 'package:CovidTracker/services/apiServices/apiFunctions.dart';
import 'package:CovidTracker/utils/color.dart';
import 'package:CovidTracker/resources/infoText.dart';
import 'package:CovidTracker/utils/loading.dart';
import 'package:CovidTracker/resources/logo.dart';
import 'package:CovidTracker/resources/submitButton.dart';
import 'package:CovidTracker/screens/acceuil.dart';
import 'package:CovidTracker/screens/register.dart';
import 'package:CovidTracker/screens/verification.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'landing.dart';


class login extends StatefulWidget {
  String toast;
   login(this.toast) ;

  @override
  _loginState createState() => _loginState(toast);
}

class _loginState extends State<login> {
  ApiFunctions apiLogin= ApiFunctions();
  bool _isObscure = true;
  String email='';
  String password='';
  String error='';
  bool emailEmpty=false;
  bool passwordEmpty=false;
  bool submit=false;
  bool loading=false;
  String toast;

  void showToast(String message){
    if(message==''){
    }else {
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 15);
    }
  }
  @override
  void initState() {
    super.initState();
    showToast(toast);
  }
  _loginState(this.toast);
  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    double h = MediaQuery.of(context).size.height;

    Widget wrapContent=
        WillPopScope( onWillPop: ()async{
          print('no go back');
          return false;
        },
        child:Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.chevron_left_rounded,
            size: h*0.040,),
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => landing())),
          color: ybcolor,
        ),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Padding(
                padding: EdgeInsets.only(top: h*0.040),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   logo()
                  ],
                ),
              ),
              if (!isKeyboard)
                FractionallySizedBox(
                  child: Padding(
                    padding: EdgeInsets.only(top: h*0.040),
                    child: Image.asset(
                      "assets/images/login.png",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  widthFactor: 0.77,
                ),
              if (!isKeyboard)
                Padding(
                  padding: EdgeInsets.only(top: h*0.030),
                  child: infoText(
                    text: "Connectez vous pour continuer.",
                    size: h*0.017,
                  ),
                ),
              Padding(padding: EdgeInsets.only(top: h*0.015)),
              SizedBox(
                height: h*0.070,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(h*0.035, h*0.010, h*0.035, 0),
                  child: TextField(
                    onChanged: (val){
                      email=val;
                    },
                    textAlign: TextAlign.center,
                    autocorrect: true,
                    decoration: InputDecoration(
                      hintText: 'Entrez votre email',
                      contentPadding: EdgeInsets.only(top: 0,right:h*0.040),
                      filled: true,
                      prefixIcon: Padding(
                          padding: const EdgeInsets.all(0),
                          child:Icon(
                            Icons.email_outlined,
                            color: ybcolor,
                          )),
                      hintStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.grey[400],
                        fontSize: 13,
                      ),
                      fillColor: Colors.white70,
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        borderSide: BorderSide(color: ybcolor, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(50.0)),
                        borderSide: const BorderSide(color: ybcolor, width: 2),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(h*0.035, h*0.010, h*0.035, 0),
                child: SizedBox(
                  height: h*0.060,
                  child: TextField(
                    onChanged: (val){
                      password=val;
                    },
                    textAlign: TextAlign.center,
                    autocorrect: true,
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      hintText: 'Entrez votre mot de passe',
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
                      ),
                      contentPadding: EdgeInsets.only(top: h*0.002),
                      filled: true,
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: ybcolor,
                      ),
                      hintStyle: TextStyle(
                          fontSize: 13,
                          fontFamily: 'Montserrat',
                          color: Colors.grey[400]),
                      fillColor: Colors.white70,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        borderSide: BorderSide(color: ybcolor, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        borderSide: BorderSide(color: ybcolor, width: 2),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(top: h*0.020)),
              FractionallySizedBox(
                widthFactor: 0.81,
                child: submitButton(
                  text: 'Connexion',
                  press: () async{
                    setState(() {
                      loading=true;
                      submit=true;
                      if(email==''){
                        loading=false;
                        emailEmpty=true;
                      }
                      if(password==''){
                        loading=false;
                        passwordEmpty=true;
                      }
                    });
                        final ConnectivityResult result = await Connectivity().checkConnectivity();

                        if(result!=ConnectivityResult.none){
                          
                         
                          
                    try {
                     var token0= await apiLogin.login(email.trimRight(), password);
                     if(token0.statusCode!=200){
                     setState(() {
                       loading=false;
                       final Map<String, dynamic> data = json.decode(token0.body);
                       error=data['msg'];
                       print(data);
                       print('{$token0.body}');
                     });
                     }
                     else{
                       var tab= token0.body.split("\"");
                       var token = tab[3];
                       final prefs = await SharedPreferences.getInstance();
                       var user=await apiLogin.getuser(token);
                       final Map<String, dynamic> data = json.decode(user.body);
                       var names = data['fullName'].split(' ');
                       var firstName = names[0];
                       var fullname=data['fullName'];
                       var email=data['email'];
                       var uid = data['uid'];
                       var birthDate=data['birthDate'];
                       print(firstName);
                       print(token);
                       await prefs.setString('firstName', firstName);
                       await prefs.setString('fullname', fullname);
                       await prefs.setString('email', email);
                       await prefs.setString('birthDate', birthDate);
                       await prefs.setString('uid', uid);
                       String pass=password;
                        await prefs.setString('password', pass);
                       bool startService = await prefs.getBool('startService') ?? false;
                       await prefs.setString("token", token);
                      
                        
   Navigator.push(context,
                             MaterialPageRoute(builder: (context) => acceuilScreen('',startService)));
                      

                     }
                     }

                    catch(e){

                      print(e.toString());
                      setState(() {
                        loading =false;

                      });
                    
                    }
                        }
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
                  color: ybcolor,
                  textColor: Colors.white,
                ),
              ),
              SizedBox(
                height: h*0.010,
              ),
              Center(
                child: Text(error,style: TextStyle(
                  color: Colors.red,
                ),),
              ),
              Padding(
                padding: EdgeInsets.only(top: h*0.015),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Verification()));
                  },
                  child: Text(
                    'Mot de passe oubliée ?',
                    style: TextStyle(
                      color: ybcolor,
                      fontFamily: 'Montserrat',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: h*0.015, bottom: h*0.020),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => register()));
                  },
                  child: Text(
                    'Vous n\'avez pas un compte?',
                    style: TextStyle(
                      color: ybcolor,
                      fontFamily: 'Montserrat',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    ));

      return  loading?  Loading() :SafeArea(
        child: wrapContent
      );

  }
}
