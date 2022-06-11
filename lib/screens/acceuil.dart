import 'dart:async';

import 'package:CovidTracker/services/apiServices/apiFunctions.dart';
import 'package:CovidTracker/resources/respBar.dart';
import 'package:CovidTracker/screens/declareScreen.dart';
import 'package:CovidTracker/screens/maintenance.dart';
import 'package:CovidTracker/screens/shareScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/color.dart';
import 'package:google_nav_bar/google_nav_bar.dart';



import '../resources/popups.dart';
import '../services/nearbyServices/nearbyServices.dart';
import 'home.dart';

late Timer timer;


class acceuilScreen extends StatefulWidget {
  String toast;
  bool startService;

  acceuilScreen(this.toast, this.startService);

  @override
  _acceuilScreenState createState() => _acceuilScreenState(toast, startService);
}

class _acceuilScreenState extends State<acceuilScreen> {
  int _selectedIndex = 0;
  PageController? _pageController;
  String toast;
  late Timer t;
  bool startService;
  nearbyServices nbService = new nearbyServices(Strategy.P2P_CLUSTER);
  _acceuilScreenState(this.toast, this.startService);



  void showToast(String message) {
    if (message == '') {
    } else {
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 15);
    }
  }

  void getService() async{
    final prefs = await SharedPreferences.getInstance();
    if(mounted){
      setState(()  {
        startService = prefs.getBool('startService') ?? false;
      });
    }
  }


  @override
  void initState() {
    print('initiates');
    super.initState(); 
    t = Timer.periodic(Duration(seconds: 1), (timer) {
      getService();
    });
    if(startService){
      Nearby().stopAdvertising();
      Nearby().stopDiscovery();
      nbService.getUserIDandAdvertise();
    }
     timer=  Timer.periodic(Duration(seconds: 20), (timer) {
       print('timer started');
        nbService.startServices(startService);
           });
    showToast(toast);
    _pageController = PageController(initialPage: 0, keepPage: true);
  }

  @override
  void dispose() {
    _pageController?.dispose();
    timer.cancel();
    t.cancel();
    print('disposed');
    super.dispose();
    showToast(toast);
  }

  String token = '';
  String storedName = '';
  bool exposure = false;
  bool active = false;
  bool check = false;
  var user;



  @override
  Widget build(BuildContext context) {

    List<Widget> _widgetOptions = <Widget>[
      home(startService),
      declareScreen(),
      shareScreen()
    ];

    double h = MediaQuery.of(context).size.height;
    Widget wrapContent = Text('');
    if (!active)
      wrapContent = WillPopScope(
        onWillPop: () => showExitPopup(context),
        child: Scaffold(
          body: PageView(
            physics: BouncingScrollPhysics(),
            controller: _pageController,
            onPageChanged: (index) {
              getService();
              setState(() => _selectedIndex = index);
            },
            children: <Widget>[
              _widgetOptions.elementAt(0),
              _widgetOptions.elementAt(1),
              _widgetOptions.elementAt(2)
            ],
          ),
          extendBodyBehindAppBar: true,
          extendBody: true,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.0),
            child: respBar(type: _selectedIndex),
          ),
          backgroundColor: Colors.white,
          bottomNavigationBar: Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.fromLTRB(
                  h * 0.010, h * 0.010, h * 0.010, h * 0.010),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(40)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: GNav(
                  padding: EdgeInsets.symmetric(
                      horizontal: h * 0.020, vertical: h * 0.010),
                  tabBackgroundColor: ybcolorOp,
                  tabs: [
                    GButton(
                      gap: 10.0,
                      iconActiveColor: ybcolor,
                      textColor: ybcolor,
                      iconColor: ybcolor,
                      icon: Icons.home,
                      text: 'Acceuil',
                    ),
                    GButton(
                      gap: 10.0,
                      iconActiveColor: ybcolor,
                      textColor: ybcolor,
                      iconColor: ybcolor,
                      icon: Icons.coronavirus,
                      text: 'Me déclarer',
                    ),
                    GButton(
                      gap: 10.0,
                      iconActiveColor: ybcolor,
                      textColor: ybcolor,
                      iconColor: ybcolor,
                      icon: Icons.share,
                      text: 'Partager',
                    ),
                  ],
                  selectedIndex: _selectedIndex,
                  onTabChange: (index) {
                    setState(() {
                      _selectedIndex = index;

                      _pageController?.animateToPage(
                        index,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.fastOutSlowIn,
                      );
                    });
                  })),
        ),
      );
    else
      wrapContent = maintenance();
    return SafeArea(
      child:  wrapContent,
    );
  }
}
