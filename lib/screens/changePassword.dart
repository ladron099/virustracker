import 'package:CovidTracker/services/apiServices/apiFunctions.dart';
import 'package:CovidTracker/utils/background.dart';
import 'package:CovidTracker/utils/color.dart';
import 'package:CovidTracker/resources/infoText.dart';
import 'package:CovidTracker/utils/loading.dart';
import 'package:CovidTracker/resources/logo.dart';
import 'package:CovidTracker/resources/submitButton.dart';
import 'package:CovidTracker/screens/login.dart';
import 'package:connectivity_plus/connectivity_plus.dart'; 
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class ChangePassword extends StatefulWidget {
  String email;
    ChangePassword({required this.email,Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState(email);
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _isObscure = true; 
  bool loading = false; 
  TextEditingController password = TextEditingController();
  TextEditingController password2 = TextEditingController();
String email;
  _ChangePasswordState(this.email);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    Widget wrapContent = loading
        ? Loading()
        : Center(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(
                    Icons.chevron_left_rounded,
                    size: h * 0.040,
                  ),
                  onPressed: () =>    Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            login(''))),
                  color: ybcolor,
                ),
              ),
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: isKeyboard ? h * 0.010 : h * 0.040),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [logo()],
                        ),
                      ),
                    ),
                    !isKeyboard
                        ? background(path: "assets/images/success.png",)
                        : SizedBox(
                            height: h * 0.1,
                          ),
                    if (!isKeyboard)
                      Padding(padding: EdgeInsets.only(top: h * 0.00)),
                    if (!isKeyboard)
                      infoText(
                        text: "Changer le mot de passe",
                        size: h * 0.017,
                      ),
                     Padding(
                padding: EdgeInsets.fromLTRB(h*0.035, h*0.010, h*0.035, 0),
                child: SizedBox(
                  height: h*0.060,
                  child: TextField(
                    controller: password,
                    textAlign: TextAlign.center,
                    autocorrect: true,
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      hintText: 'Entrez le mot de passe',
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
           
                   Padding(
                padding: EdgeInsets.fromLTRB(h*0.035, h*0.010, h*0.035, 0),
                child: SizedBox(
                  height: h*0.060,
                  child: TextField(
                    controller: password2,
                    textAlign: TextAlign.center,
                    autocorrect: true,
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      hintText: 'Confirmer le mot de passe',
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
           
                 
                    Padding(padding: EdgeInsets.only(top: h * 0.015)),
                    FractionallySizedBox(
                      widthFactor: 0.84,
                      child: submitButton(
                        text: "Continuer",
                        press: () async {  final ConnectivityResult result = await Connectivity().checkConnectivity();

                        if(result!=ConnectivityResult.none){
                      
                            if(!RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$' ).hasMatch(password.text)){
                                  Fluttertoast.showToast(
                              msg: "Le mot de passe doit contenir au moins 8 caractères dont une majuscule, une minuscule et un chiffre",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                                if(password.text != password2.text){
                            Fluttertoast.showToast(
                              msg: "Les mots de passe ne correspondent pas",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                            
                            
                            }
                            }else{
                               print(email);
                              ApiFunctions a= ApiFunctions();
                              var response = await a.resetPassword(email, password.text);
                              print(response.body);
                              if(response.statusCode == 200){
                                   Fluttertoast.showToast(
                              msg: "mot de passe changé avec success",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                                    Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            login('')));      

                            }
                            else{
                                      Fluttertoast.showToast(
                              msg: "erreur dans le serveur",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                            }
                                
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
                      height: 20,
                    ),
                   
                  ],
                ),
              ),
            ),
          );
    return loading ? Loading() : SafeArea(child: wrapContent);
  }
}
