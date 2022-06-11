import 'package:CovidTracker/services/apiServices/apiFunctions.dart';
import 'package:CovidTracker/utils/background.dart';
import 'package:CovidTracker/utils/color.dart';
import 'package:CovidTracker/resources/errorMessage.dart';
import 'package:CovidTracker/resources/infoText.dart';
import 'package:CovidTracker/utils/loading.dart';
import 'package:CovidTracker/resources/logo.dart';
import 'package:CovidTracker/resources/submitButton.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import 'changePassword.dart';

class Verification extends StatefulWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  bool _isObscure = true;
  bool submitValid = false;
  bool isEnvoye = false;
  bool loading = false;
  String error = '';
  TextEditingController email = TextEditingController();
  OtpFieldController otp = OtpFieldController();
  String verificationCode = '';
  EmailAuth emailAuth = EmailAuth(
    sessionName: "Sample session",
  );
  @override
  void initState() {
    super.initState();
    emailAuth = new EmailAuth(
      sessionName: "Virus Tracker",
    );

    /// Configuring the remote server
  }

  verify(String verification) {
    print(emailAuth.validateOtp(
        recipientMail: email.value.text, userOtp: verification));
    return emailAuth.validateOtp(
        recipientMail: email.value.text, userOtp: verification);
  }

  void sendOtp() async {
    bool result =
        await emailAuth.sendOtp(recipientMail: email.value.text, otpLength: 5);
    if (result) {
      setState(() {
        submitValid = true;
        loading = false;
        Fluttertoast.showToast(
            msg: 'Numero de verifications envoyé avec succès',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 15);
        //  otp.setFocus(1);
      });
    }
    else {
      setState(() {
        submitValid = false;
        loading = false;
        Fluttertoast.showToast(
            msg: 'Erreur d\'envoi du numero de verifications',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 15);
      });
    }
  }

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
                        ? background(path: "assets/images/verifier.png")
                        : SizedBox(
                            height: h * 0.1,
                          ),
                    if (!isKeyboard)
                      Padding(padding: EdgeInsets.only(top: h * 0.00)),
                    if (!isKeyboard)
                      infoText(
                        text: "Réinitialisation du mot de passe",
                        size: h * 0.017,
                      ),
                    SizedBox(
                      height: h * 0.100,
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              h * 0.035, h * 0.030, h * 0.035, 0),
                          child: TextField(
                            controller: email,
                            textAlign: TextAlign.center,
                            autocorrect: true,
                            decoration: InputDecoration(
                              hintText: 'Entrez votre email',
                              contentPadding: EdgeInsets.only(
                                  top: h * 0.002, left: h * 0.040),
                              filled: true,
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: ybcolor,
                              ),
                              hintStyle: TextStyle(
                                  fontSize: h * 0.015,
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
                    submitValid
                        ? Padding(
                            padding: EdgeInsets.symmetric(vertical: h * 0.039),
                            child: OTPTextField(
                              controller: otp,
                              length: 6,
                              width: MediaQuery.of(context).size.width,
                              fieldWidth: 20,
                              style: TextStyle(fontSize: 17),
                              textFieldAlignment: MainAxisAlignment.spaceAround,
                              fieldStyle: FieldStyle.underline,
                              onCompleted: (pin) {
                                setState(() {
                                  verificationCode = pin;
                                });
                              },
                            ),
                          )
                        : Text(""),
                    Padding(padding: EdgeInsets.only(top: h * 0.015)),
                    FractionallySizedBox(
                      widthFactor: 0.84,
                      child: submitButton(
                        text: isEnvoye ? "Continuer" : "Envoyer",
                         press: () async {  final ConnectivityResult result = await Connectivity().checkConnectivity();

                        if(result!=ConnectivityResult.none){
                          ApiFunctions a = ApiFunctions();
                          var response = await a.checkEmail(email.text);

                          if (response.statusCode == 200) {
                            if (isEnvoye == false) {
                              setState(() {
                                isEnvoye = true;
                                loading = true;
                              });
                              sendOtp();
                              print(email.text);
                            } else {
                              print(verificationCode);
                              print(verify(verificationCode));
                              if (verify(verificationCode)) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ChangePassword(email:email.text)));
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'Numero de verifications invalide',
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.TOP,
                                    timeInSecForIosWeb: 2,
                                    backgroundColor: danger,
                                    textColor: Colors.white,
                                    fontSize: 15);
                              }
                            }
                          }
                          else{
                             setState(() {
                                loading = false;
                              });
                               Fluttertoast.showToast(
                                    msg: 'Compte inexistent',
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.TOP,
                                    timeInSecForIosWeb: 2,
                                    backgroundColor: danger,
                                    textColor: Colors.white,
                                    fontSize: 15);
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
    return loading ? Loading() : SafeArea(child:  wrapContent);
  }
}
