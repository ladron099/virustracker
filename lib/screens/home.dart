import 'dart:convert';
import 'package:CovidTracker/services/apiServices/apiFunctions.dart';
import 'package:CovidTracker/resources/infoBox.dart';
import 'package:CovidTracker/resources/switchState.dart';
import 'package:CovidTracker/screens/maintenance.dart';
import 'package:CovidTracker/resources/infectedBox.dart';
import 'package:CovidTracker/screens/permissions.dart';
import 'package:CovidTracker/screens/symptomes.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/nearbyServices/nearbyServices.dart';
import '../utils/color.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_background/flutter_background.dart';

class home extends StatefulWidget {
  bool startService;
  home(this.startService);
  @override
  _homeState createState() => _homeState(startService);
}

class _homeState extends State<home> {
  
  final _controller = ValueNotifier<bool>(false);
  ApiFunctions apiUser = ApiFunctions();
  bool _checked = false;
  bool perms = false;
  String storedName = '';
  var exposure = false;
  String token = '';
  String fullname = "";
  String msg = "";
  bool active = false;
  String email = '';
  var user;
  nearbyServices nbService = new nearbyServices(Strategy.P2P_CLUSTER);
  String birthDate = '';
  bool infected = false;
  late final Map<String, dynamic> data;
  bool startService;

  _homeState(this.startService);

  final Uri _url = Uri.parse("https://www.sante.gov.ma/Pages/Accueil.aspx");

  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  final androidConfig = FlutterBackgroundAndroidConfig(
    notificationTitle: "Virus Tracker",
    notificationText: "Le service est activé.",
    notificationImportance: AndroidNotificationImportance.High,
    notificationIcon:
        AndroidResource(name: 'background_icon', defType: 'drawable'),
  );

  void enableBackground() async {
    bool success = await FlutterBackground.enableBackgroundExecution();
  }

  void disableBackground() async {
    bool success = await FlutterBackground.disableBackgroundExecution();
  }

  _getusername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      storedName = prefs.getString('firstName') ?? '';
      exposure = prefs.getBool('exposure') ?? false;
    });
    print('Name of logged user: ${storedName}');
  }

  _getInfected() async {
    final prefs = await SharedPreferences.getInstance();
    token = await prefs.getString('token')!;
    print(token);
     final ConnectivityResult result = await Connectivity().checkConnectivity();
     if(result != ConnectivityResult.none){
     user = await apiUser.getuser(token);
    data = json.decode(user.body);
    print(data);
    if (mounted) {
      setState(() {
        exposure = data['infected'];
        prefs.setBool('exposure', exposure);
      });
    }
     }
    
  }

  _setService() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('startService', startService);
    print('set service to {$startService}');
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

  Future<void> initBackground() async {
    bool success =
        await FlutterBackground.initialize(androidConfig: androidConfig);
  }
  updatetok() async {
      ApiFunctions pushNotif = ApiFunctions();
      final prefs=await SharedPreferences.getInstance();
      token = (prefs.getString('token') ?? '');
      String playerId=prefs.getString('fcm')??'';
      print('${token}hhhhhhhhhhhhhhhh');
      print('${playerId}hhhhhhhhhhhhhhhh');
      try{
        var e=await pushNotif.updatePlayerId(playerId,token);
        print(e.statusCode);
        print(e.body+'kkkkkkk');
      }
      catch(e){
        print(e);
      }
  }
  void initState() {
    super.initState();
    updatetok();
    initBackground().whenComplete(() {
      if (startService) {
        enableBackground();
      }
    });
    getService();
    _getInfected();
    _getusername();
    _controller.addListener(() {
      setState(() {
        if (_controller.value) {
          _checked = true;
        } else {
          _checked = false;
        }
      });
    });
  }

  void getService() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      startService = prefs.getBool('startService') ?? false;
      ;
    });
  }

  void _launchUrl() async {
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    Widget wrapContent = Text("error");

    if (active == false) {
      wrapContent = Stack(
        children: [
        Flex(
          direction: Axis.vertical,
          children:[
            Flexible(
            child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.only(top: h*0.33, bottom: h * 0.13),
                scrollDirection: Axis.vertical,
                child: Column(
                children: [
                  exposureBox(exposure: exposure),
                  infoBox(
                    mainText: "Consulter les symptomes du virus",
                    desc:
                        "Vérifiez si vous avez l’un des symptomes du virus.",
                    image: "assets/images/undraw_doctor.png",
                    shadowColor: Colors.grey.withOpacity(0.2),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => symptomes()));
                    },
                    textColor: ybcolor,
                  ),
                  infoBox(
                    textColor: ybcolor,
                    mainText: "Consulter le site sante.gov.ma",
                    desc:
                        "Consulter le Portail Officiel du Ministère de la santé au Maroc.",
                    image: "assets/images/logo-ministere-sante.png",
                    shadowColor: Colors.grey.withOpacity(0.2),
                    onPressed: () {
                      _launchUrl();
                    },
                  ),
                ])),
          ),
        ]),
          Container(
            width: double.infinity,
            height: h * 0.33,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60)),
              gradient: boxgradient,
            ),
            child: Container(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(h * 0.050, h * 0.140, h * 0.050, 0),
                  child: Column(
                      children: [
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
                                SizedBox(
                                  width: 200,
                                  child: Text(
                                    '$storedName',
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                    softWrap: false,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.w900,
                                      fontSize: h * 0.03,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                    padding: EdgeInsets.only(bottom: h * 0.005),
                                    child: FlutterSwitch(
                                        activeText: '',
                                        inactiveText: '',
                                        activeColor: ybcolor3,
                                        width: 75.0,
                                        height: 40.0,
                                        valueFontSize: 10.0,
                                        toggleSize: 40.0,
                                        value: startService,
                                        borderRadius: 20.0,
                                        padding: 2.0,
                                        showOnOff: true,
                                        onToggle: (val) async {
                                          if (!startService) {
                                            if (!await checkPermissions()) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          permissions()));
                                            } else {
                                              nbService.getUserIDandAdvertise();
                                              setState(() {
                                                startService = val;
                                                print(
                                                    'Home service variable is: $startService');
                                              });
                                              initBackground().whenComplete(() {
                                                print('enabled background');
                                                enableBackground();
                                              });
                                            }
                                          } else
                                            setState(() {
                                              startService = val;
                                              print(
                                                  'Home service variable is: $startService');
                                            });
                                          _setService();
                                          if (FlutterBackground
                                              .isBackgroundExecutionEnabled) {
                                            disableBackground();
                                          }
                                          Nearby().stopDiscovery();
                                          Nearby().stopAdvertising();
                                        })),
                                switchState(state: startService),
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
          ),
      ]);
    } else {
      wrapContent = maintenance();
    }
    return wrapContent;
  }
}
