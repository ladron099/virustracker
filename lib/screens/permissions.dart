import 'package:CovidTracker/screens/acceuil.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/color.dart';
import '../resources/logo.dart';
import '../resources/submitButton.dart';

class permissions extends StatefulWidget {
  const permissions({Key? key}) : super(key: key);

  @override
  State<permissions> createState() => _permissionsState();
}

class _permissionsState extends State<permissions> {
  void checkLocation() async {
    var c = await Permission.locationAlways.status;
    if (c.isGranted) {
      print('Location permissions granted');
    } else {
      print('Location permissions not granted.. Requesting..');
      await Permission.locationAlways.request();
    }
  }

  void checkLocationEn() async {
    if (await Nearby().checkLocationEnabled()) {
      print('Location services ON');
    } else {
      print('Location services OFF.. Turning on..');
      Nearby().enableLocationServices();
    }
  }

  bool startService = false;

  _setService() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('startService', startService);
    print('set service to {$startService}');
  }

  bool perms = false;

  _setPerms() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('perms', perms);
    print('set perms to {$perms}');
  }

  Future<void> checkBAdvertise() async {
    var c = await Permission.bluetoothAdvertise.status;
    if (c.isGranted == true) {
      print('Bluetooth Advertise permissions granted');
    } else {
      print('Bluetooth Advertise permissions not granted.. Requesting..');
      Permission.bluetoothAdvertise.request();
    }
  }

  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future<void> checkBScan() async {
    var c = await Permission.bluetoothScan.status;
    if (c.isGranted == true) {
      print('Bluetooth Scan permissions granted');
    } else {
      print('Bluetooth Scan permissions not granted.. Requesting..');
      Permission.bluetoothScan.request();
    }
  }

  Future<bool> checkPermissions() async {
    List<bool> statuses = [
      await Permission.bluetoothAdvertise.isGranted,
      await Permission.bluetoothScan.isGranted,
      await Permission.locationAlways.isGranted,
      await Nearby().checkLocationEnabled()
    ];

    if (statuses.contains(false)) {
      print('Some of the permissions arent granted..');
      return false;
    } else
      print('All permissions granted.');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          splashRadius: 1,
          icon: Icon(
            Icons.chevron_left_rounded,
            size: h * 0.040,
          ),
          onPressed: () => Navigator.pop(context),
              // Navigator.push(
              // context,
              // MaterialPageRoute(
              //     builder: (context) => acceuilScreen('', false))),
          color: ybcolor,
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: h * 0.050),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [logo()],
              ),
            ),
            FractionallySizedBox(
              child: Padding(
                padding: EdgeInsets.only(top: h * 0.040),
                child: Image.asset(
                  "assets/images/permission.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
              widthFactor: 0.9,
            ),
            Padding(
              padding: EdgeInsets.only(top: h * 0.030),
              child: Container(
                margin: EdgeInsets.only(
                    left: h * 0.05, right: h * 0.05, top: h * 0.02),
                child: Text(
                  'Pour que VIRUS TRACKER fonctionne, vous devez accorder les permissions Bluetooth et Localisation.\n Pour plus d\'informations consulter la section: Comment fonctionne VIRUS TRACKER? dans paramétres.',
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontStyle: FontStyle.normal,
                    fontSize: h * 0.013,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(0),
              child: FractionallySizedBox(
                child: Column(
                  children: [
                    if (!perms) ...[
                      Padding(
                        padding: EdgeInsets.only(top: h * 0.020),
                        child: Text(
                          'Permissions non accordés.',
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                            fontSize: h * 0.017,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: h * 0.05),
                        child: submitButton(
                          text: 'Accorder les permissions',
                          color: ybcolor,
                          textColor: Colors.white,
                          press: () async {
                            Map<Permission, PermissionStatus> req = await [
                              await Permission.bluetoothAdvertise,
                              await Permission.bluetoothScan,
                              await Permission.locationWhenInUse,
                            ].request();
                            await Permission.locationAlways.request();
                            List<bool> statuses = [
                              await Permission.bluetoothAdvertise.isGranted,
                              await Permission.bluetoothScan.isGranted,
                              await Permission.locationAlways.isGranted,
                              await Nearby().checkLocationEnabled()
                            ];
                            if (statuses.contains(false)) {
                              print('Some of the permissions arent granted..');
                              setState(() {
                                perms = false;
                              });
                              _setPerms();
                            } else {
                              print('All permissions granted.');
                              setState(() {
                                perms = true;
                              });
                              _setPerms();
                            }
                          },
                        ),
                      ),
                    ],
                    if (perms) ...[
                      Padding(
                        padding: EdgeInsets.only(top: h * 0.020),
                        child: Text(
                          'Permissions accordés.',
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                            fontSize: h * 0.017,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: h * 0.020),
                        child: submitButton(
                          text: "Continuer",
                          press: () async {
                            if (perms) {
                              timer.cancel();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          acceuilScreen('', true)));
                              Fluttertoast.showToast(
                                  msg: 'Permissions accordés avec succés',
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 2,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 15);
                              setState(() {
                                startService = true;
                              });
                              _setService();
                            } else {
                              timer.cancel();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          acceuilScreen('', false)));
                              Fluttertoast.showToast(
                                  msg:
                                      'Permissions non accordés. Veuillez réessayer.',
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 2,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 15);
                              _setService();
                            }
                          },
                          color: ybcolor,
                          textColor: Colors.white,
                        ),
                      ),
                    ]
                  ],
                ),
                widthFactor: 0.7,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
