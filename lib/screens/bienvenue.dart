import 'package:CovidTracker/utils/dot.dart';
import 'package:CovidTracker/utils/color.dart';
import 'package:CovidTracker/resources/submitButton.dart';
import 'package:CovidTracker/screens/maintenance.dart';
import 'package:flutter/material.dart';
import 'package:CovidTracker/resources/bienvenueItem.dart';
import 'package:CovidTracker/utils/slide.dart';
import 'package:CovidTracker/screens/landing.dart';

import '../resources/popups.dart';
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
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    Widget wrapContent=Text('');
    if(!active)
      wrapContent=  WillPopScope(
        onWillPop: () => showExitPopup(context),
        child: Scaffold(
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
    ),
      );
    else wrapContent=maintenance();
    return SafeArea(
      child: wrapContent,
    );
  }
}
