import 'package:CovidTracker/models/dot.dart';
import 'package:CovidTracker/resources/color.dart';
import 'package:CovidTracker/resources/conn.dart';
import 'package:CovidTracker/resources/submitButton.dart';
import 'package:CovidTracker/screens/maintenance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:CovidTracker/widgets/bienvenueItem.dart';
import 'package:CovidTracker/models/slide.dart';
import 'package:CovidTracker/screens/landing.dart';

import '../resources/logo.dart';

class bienvenue extends StatefulWidget {
  @override
  State<bienvenue> createState() => _bienvenueState();
}

class _bienvenueState extends State<bienvenue> {
  final _pageController = new PageController(initialPage: 0);
  static int _pageSelected = 0;

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
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
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             logo(),
              Container(
                constraints: BoxConstraints(
                  maxHeight: 450,
                  maxWidth: double.infinity,
                ),
                child: PageView.builder(
                  onPageChanged: (int i) => {
                    setState(() => {_pageSelected = i}),
                  },
                  controller: _pageController,
                  itemCount: slide.slideList.length,
                  itemBuilder: (ctx, index) => bienvenueItem(index),
                ),
              ),

              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < slide.slideList.length; i++)
                      i == _pageSelected ? dot(true) : dot(false),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: h*0.025, bottom: h*0.010),
                  child: FractionallySizedBox(
                    widthFactor: 0.77,
                    child: submitButton(
                      text: "Continuer",
                      press: () {
                        if(_pageSelected== slide.slideList.length - 1){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => landing()));
                        }
                        _pageController.nextPage(duration: Duration(milliseconds: 250),
                            curve: Curves.easeIn);
                      },
                      color: ybcolor,
                      textColor: Colors.white,
                    ),
                  )
              ),
              TextButton(onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => landing()));
                    }, child: Text('Passer',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: ybcolor,
                  )))
            ],
          ),
        ),
      ),
    );
    else wrapContent=maintenance();
    return SafeArea(
      child:conn(clas: wrapContent,)
    );
  }
}
