import 'package:CovidTracker/resources/respBar.dart';
import 'package:CovidTracker/screens/declareScreen.dart';
import 'package:CovidTracker/screens/maintenance.dart';
import 'package:CovidTracker/screens/shareScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../DAL/authService.dart';
import '../resources/color.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../resources/conn.dart';
import 'home.dart';
import 'landing.dart';

class acceuilScreen extends StatefulWidget {
  const acceuilScreen({Key? key}) : super(key: key);

  @override
  _acceuilScreenState createState() => _acceuilScreenState();
}

class _acceuilScreenState extends State<acceuilScreen> {
  final AuthService _auth = AuthService();
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    home(),
    declareScreen(),
    shareScreen()
  ];
  PageController? _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0,keepPage: true);

  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }
  bool active=false;
  _betch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('adminActions')
          .doc('maintenance')
          .get()
          .then((ds) {
        setState(() {
          active=ds.get('activated');
        });
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    _betch();
    Widget wrapContent=Text('');
    if(!active)
      wrapContent= Scaffold(
      body: PageView(
        physics: BouncingScrollPhysics(),
        controller: _pageController,
        onPageChanged: (index) {

          setState(() => _selectedIndex = index);
        },
        children: <Widget>[
          _widgetOptions.elementAt(0),
          _widgetOptions.elementAt(1),
          _widgetOptions.elementAt(2)
        ],
      ),
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: respBar(type: _selectedIndex),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.fromLTRB(h*0.010, h*0.010, h*0.010, h*0.010),
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
              padding: EdgeInsets.symmetric(horizontal: h*0.020, vertical: h*0.010),
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

                  _pageController?.animateToPage(index,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.fastOutSlowIn,
                  );
                });
              })),
    );
    else
      wrapContent=maintenance();
    return SafeArea(
      child:conn(clas:wrapContent),
    );
  }
}
