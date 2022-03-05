import 'package:CovidTracker/resources/background.dart';
import 'package:CovidTracker/resources/color.dart';
import 'package:CovidTracker/resources/conn.dart';
import 'package:CovidTracker/resources/infoText.dart';
import 'package:CovidTracker/resources/loading.dart';
import 'package:CovidTracker/resources/logo.dart';
import 'package:CovidTracker/resources/submitButton.dart';
import 'package:CovidTracker/screens/acceuil.dart';
import 'package:CovidTracker/screens/bienvenue.dart';
import 'package:CovidTracker/screens/register.dart';
import 'package:CovidTracker/screens/verification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../DAL/authService.dart';
import '../DAL/utilisateur.dart';
import 'home.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  bool _isObscure = true;
  String email='';
  String password='';
  String error='';
  bool emailEmpty=false;
  bool passwordEmpty=false;
  bool submit=false;
  bool loading=false;
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    double h = MediaQuery.of(context).size.height;
    final use = Provider.of<utilisateur?>(context);
    Widget wrapContent=Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.chevron_left_rounded,
            size: h*0.040,),
          onPressed: () => Navigator.pop(context),
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
              if(emailEmpty==true && submit==true && error=='')
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text('Texte vide',style: TextStyle(color: Colors.red),),
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
              if(passwordEmpty==true && submit==true && error=='')
                Padding(
                  padding: EdgeInsets.only(top: h*0.005),
                  child: Text('Texte vide',style: TextStyle(color: Colors.red),),
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
                    dynamic a = await _auth
                        .signInWithEmailAndPassword(email.trimRight(), password);
                    print('${email.trimRight()}gg');
                    if (a == null)
                      setState(() {
                        loading = false;
                        if(password!=''&&email!='')
                          error = 'Informations incorrectes. Veuillez réssayer';
                      });
                    else {
                      print('Vous étes connecté');
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
                            builder: (context) => verification()));
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
    );
    if (use == null )
      return  loading?  Loading() :SafeArea(
        child:conn(clas: wrapContent,)
      );
    else{
      return acceuilScreen();
    }
  }
}
