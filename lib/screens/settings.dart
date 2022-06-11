import 'package:CovidTracker/screens/changerMdp.dart';
import 'package:CovidTracker/screens/fonctScreen.dart';
import 'package:CovidTracker/screens/maintenance.dart';
import 'package:CovidTracker/screens/profile.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/color.dart';
import '../resources/popups.dart';
import 'deleteAccount.dart';

class settingsScreen extends StatefulWidget {
  const settingsScreen({Key? key}) : super(key: key);

  @override
  _settingsScreenState createState() => _settingsScreenState();
}

class _settingsScreenState extends State<settingsScreen> {
  String email = '';
  String fullname = '';
  String token = '';
  _getusername() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      fullname = (prefs.getString('fullname') ?? '');
      email = (prefs.getString('email') ?? '');
      token = (prefs.getString('token') ?? '');
    });
  }

  bool active = false;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    _getusername();
    Widget wrapContent = Text('');
    if (!active)
      wrapContent = Center(
          child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  "Paramétres",
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
                actions: [
                  IconButton(
                    splashRadius: 1,
                    onPressed: () async {
                        final ConnectivityResult result = await Connectivity().checkConnectivity();

                        if(result!=ConnectivityResult.none){showLogoutPopup(context);}else{   setState(() {
   
                             Fluttertoast.showToast(
          msg: 'Une erreur est survenue. Veuillez verifiez votre connexion internet et réssayer.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: danger,
          textColor: Colors.white,
          fontSize: 15);
                          });}
                    },
                    icon: Icon(Icons.logout_rounded),
                    color: ybcolor,
                  )
                ],
              ),
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5,
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 5)
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/images/icon.png'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(h * 0.015),
                      child: Column(children: [
                        Text(
                          "$fullname",
                          style: TextStyle(
                            color: ybcolor,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "$email",
                          style: TextStyle(
                            color: ybcolor,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w100,
                            fontSize: 13,
                          ),
                        ),
                      ]),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: h * 0.020),
                      height: 1,
                      width: 150,
                      color: Colors.grey[400],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(h * 0.040, 0, h * 0.040, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: h * 0.030,
                                left: h * 0.010,
                                bottom: h * 0.010),
                            child: Text(
                              'Compte',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: ybcolor,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.15),
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                  offset: Offset(
                                      0, 0), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      h * 0.020, h * 0.020, h * 0.020, 0),
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 5,
                                          blurRadius: 10,
                                          offset: Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    profileScreen()));
                                      },
                                      splashColor: ybcolor,
                                      child: Padding(
                                        padding: EdgeInsets.all(h * 0.010),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.account_circle),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: h * 0.020),
                                                  child: Text(
                                                    'Profile',
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Icon(Icons.chevron_right),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(h * 0.020,
                                      h * 0.020, h * 0.020, h * 0.020),
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 5,
                                          blurRadius: 10,
                                          offset: Offset(0,
                                              0), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    changerMdp(token, email)));
                                      },
                                      splashColor: ybcolor,
                                      child: Padding(
                                        padding: EdgeInsets.all(h * 0.010),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.lock),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: h * 0.020),
                                                  child: Text(
                                                    'Changer votre mot de passe',
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Icon(Icons.chevron_right),
                                          ],
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
                    // END OF FIRST PART 'COMPTE' -- START NEXT BOX
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          h * 0.040, 0, h * 0.040, h * 0.040),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: h * 0.030,
                                left: h * 0.010,
                                bottom: h * 0.010),
                            child: Text(
                              'Services et Confidentialité',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: ybcolor,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.15),
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                  offset: Offset(
                                      0, 0), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      h * 0.020, h * 0.020, h * 0.020, 0),
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 5,
                                          blurRadius: 10,
                                          offset: Offset(0, 0),
                                        ),
                                      ],
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    fonctScreen()));
                                      },
                                      splashColor: ybcolor,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: h*0.010,right: h*0.010),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.coronavirus),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: h * 0.015, right: 0),
                                                  child: RichText(
                                                    text: TextSpan(children: <
                                                        TextSpan>[
                                                      TextSpan(
                                                          text:
                                                              "À propos de ",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontFamily:
                                                                  'Montserrat',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w100,
                                                              fontSize: 13)),
                                                      TextSpan(
                                                        text: " VIRUS TRACKER?",
                                                        style: TextStyle(
                                                          color: ybcolor,
                                                          fontFamily:
                                                              'Montserrat',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 11,
                                                        ),
                                                      )
                                                    ]),
                                                  ),
                                                ),
                                               
                                              ],
                                              
                                            ), Icon(Icons.chevron_right),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(h * 0.020,
                                      h * 0.020, h * 0.020, h * 0.020),
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 5,
                                          blurRadius: 10,
                                          offset: Offset(0,
                                              0), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: InkWell(
                                      onTap: () {

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DeleteAccount()));
                                      },
                                      splashColor: ybcolor,
                                      child: Padding(
                                        padding: EdgeInsets.all(h * 0.010),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.close),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: h * 0.015),
                                                  child: Text(
                                                    'Supprimer mon compte',
                                                    style:
                                                        TextStyle(fontSize: 13),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Icon(Icons.chevron_right),
                                          ],
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
                    )
                  ],
                ),
              )));
    else
      wrapContent = maintenance();

    return SafeArea(child: wrapContent);
  }
}
