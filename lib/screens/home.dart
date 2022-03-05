import 'dart:async';

import 'package:CovidTracker/resources/infoBox.dart';
import 'package:CovidTracker/resources/switchState.dart';
import 'package:CovidTracker/screens/maintenance.dart';
import 'package:CovidTracker/resources/infectedBox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../resources/color.dart';
import '../resources/conn.dart';
import 'package:url_launcher/url_launcher.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  final _controller = ValueNotifier<bool>(false);
  bool _checked = false;
  String name = "";
  String storedName = '';
  var exposure = false;
  String fullname = "";
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  String _address = "...";
  String _name = "...";

  Timer? _discoverableTimeoutTimer;
  int _discoverableTimeoutSecondsLeft = 0;

  String msg = "";
  bool active = false;
  String email = '';
  bool infected = false;
  _fetch() async {
    final prefs = await SharedPreferences.getInstance();
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        setState(() {
          fullname = ds.get('fullName');
          infected = ds.get('infected');
          var names = fullname.split(' ');
          name = names[0];
          email = ds.get('email');
        });
      });
    }
    await prefs.setString('name', name);
    await prefs.setString('fullname', fullname);
    await prefs.setBool('exposure', infected);
    await prefs.setString('email', email);
  }

  _getusername() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      storedName = (prefs.getString('name') ?? '');
      exposure = (prefs.getBool('exposure') ?? false);
    });
  }

  _betch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('adminActions')
          .doc('maintenance')
          .get()
          .then((ds) {
        setState(() {
          msg = ds.get('message');
          active = ds.get('activated');
        });
      });
    }
  }

  _checkBluetooth() async {
    if (await FlutterBluetoothSerial.instance.isEnabled == true) {
      setState(() {
        _controller.value = true;
        _checked = true;
      });
    } else {
      setState(() {
        _controller.value = false;
        _checked = false;
      });
    }
  }

  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {

        if (_controller.value) {
          _checked = true;
        } else {
          _checked = false;
        }
      });
    });
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    Future.doWhile(() async {
      // Wait if adapter not enabled
      if ((await FlutterBluetoothSerial.instance.isEnabled) ?? false) {
        return false;
      }
     await Future.delayed(Duration(seconds: 12));
      return true;
    }).then((_) {
      // Update the address field
      FlutterBluetoothSerial.instance.address.then((address) {
        setState(() {
          _address = address!;
        });
      });
    });

    FlutterBluetoothSerial.instance.name.then((name) {
      setState(() {
        _name = name!;
      });
    });

    // Listen for futher state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;

        // Discoverable mode is disabled when Bluetooth gets disabled
        _discoverableTimeoutTimer = null;
        _discoverableTimeoutSecondsLeft = 0;
      });
    });
  }

  olaunch(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }



  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    Widget wrapContent = Text("error");
    _checkBluetooth();
    _fetch();
    _betch();
    _getusername();
    if (active == false) {
      wrapContent = Column(children: [
        Container(
          width: double.infinity,
          height: h * 0.33,
          decoration: BoxDecoration(
            gradient: boxgradient,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(60),
                bottomRight: Radius.circular(60)),
          ),
          child: Padding(
              padding: EdgeInsets.fromLTRB(h * 0.050, h * 0.140, h * 0.050, 0),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bienvenue',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w900,
                            fontSize: h * 0.017,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          '$storedName',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w900,
                            fontSize: h * 0.03,
                          ),
                          textAlign: TextAlign.left,
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: h * 0.005),
                          child:   Switch(
                            value: _bluetoothState.isEnabled,
                            onChanged: (bool value) {
                              // Do the request and update with the true value then
                              future() async {
                                // async lambda seems to not working
                                if (value)
                                  await FlutterBluetoothSerial.instance.requestEnable();
                                else
                                  await FlutterBluetoothSerial.instance.requestDisable();
                              }

                              future().then((_) {
                                setState(() {});
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(top: h * 0.030),
                    child: Text(
                      'Vous pouvez continuez a utiliser votre téléphone, mais garder le Bluetooth activé.',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: h * 0.011,
                      ),
                      textAlign: TextAlign.left,
                    )),
              ])),
        ),
        Container(
          child: Flexible(
            child: ListView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.only(bottom: h * 0.030),
                scrollDirection: Axis.vertical,
                children: [
                  infectedBox(infected: exposure),
                  infoBox(
                    mainText: "Consulter les symptomes du virus",
                    desc:
                        "Vérifiez si vous avez l’un des symptomes du Covid-19 ",
                    image: "assets/images/undraw_doctor.png",
                    shadowColor: Colors.grey.withOpacity(0.2),
                    onPressed: () {},
                    textColor: ybcolor,
                  ),
                  infoBox(
                    textColor: ybcolor,
                    mainText: "Consulter le site sante.gov.ma",
                    desc:
                        "Consulter le Portail Officiel du Ministère de la santé au Maroc",
                    image: "assets/images/logo-ministere-sante.png",
                    shadowColor: Colors.grey.withOpacity(0.2),
                    onPressed: () {
                      olaunch("https://www.sante.gov.ma/Pages/Accueil.aspx");
                    },
                  ),
                ]),
          ),
        )
      ]);
    } else {
      wrapContent = maintenance();
    }
    return conn(clas: wrapContent);
  }
}
