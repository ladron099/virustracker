
import 'package:CovidTracker/screens/maintenance.dart';
import 'package:flutter/material.dart';
import '../utils/color.dart';


class symptomes extends StatefulWidget {
  const symptomes({Key? key}) : super(key: key);

  @override
  State<symptomes> createState() => _symptomesState();
}

class _symptomesState extends State<symptomes> {
  bool active = false;


  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    Widget wrapContent=Text('');
    if(!active){
      wrapContent=Center(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "Symptomes",
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
            ),
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(h*0.045,0,h*0.045,0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Si vous ressentez l'un de ces symptômes ci-dessous, nous vous recommandons de faire un test de dépistage de virus.",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w100,
                              fontSize: h*0.015,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ])
                ),
                Padding(
                  padding: EdgeInsets.all(h*0.030),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(h*0.01),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                  offset: Offset(0, 0), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Card(
                              color: Colors.transparent,
                              elevation: 0,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(h*0.025,h*0.020,h*0.025,h*0.020),
                                child: Column(
                                  children: [
                                    Container(
                                      width: h*0.070,
                                      height: h*0.070,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage('assets/images/symptome-1.png'),
                                            fit: BoxFit.fill
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: h*0.010,
                                    ),
                                    Container(
                                      width: h*0.1,
                                      child: Text(
                                        "Fièvre ou frissons",
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w100,
                                          fontSize: h*0.012,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(h*0.010),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                  offset: Offset(0, 0), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Card(
                              color: Colors.transparent,
                              elevation: 0,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(h*0.025,h*0.020,h*0.025,h*0.020),
                                child: Column(
                                  children: [
                                    Container(
                                      width: h*0.070,
                                      height: h*0.070,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage('assets/images/symptome-3.png'),
                                            fit: BoxFit.fill
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: h*0.010,
                                    ),
                                    Container(
                                      width: h*0.1,
                                      child: Text(
                                        "Congestion ou nez qui coule",
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w100,
                                          fontSize: h*0.012,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(h*0.010),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                  offset: Offset(0, 0), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Card(
                              color: Colors.transparent,
                              elevation: 0,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(h*0.025,h*0.020,h*0.025,h*0.020),
                                child: Column(
                                  children: [
                                    Container(
                                      width: h*0.070,
                                      height: h*0.070,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage('assets/images/symptome-5.png'),
                                            fit: BoxFit.fill
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: h*0.010,
                                    ),
                                    Container(
                                      width: h*0.1,
                                      child: Text(
                                        "Maux de\n gorge",
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w100,
                                          fontSize: h*0.012,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(h*0.010),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                  offset: Offset(0, 0), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Card(
                              color: Colors.transparent,
                              elevation: 0,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(h*0.025,h*0.020,h*0.025,h*0.020),
                                child: Column(
                                  children: [
                                    Container(
                                      width: h*0.070,
                                      height: h*0.070,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage('assets/images/symptome-2.png'),
                                            fit: BoxFit.fill
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: h*0.010,
                                    ),
                                    Container(
                                      width: h*0.1,
                                      child: Text(
                                        "Une toux qui s'aggrave",
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w100,
                                          fontSize: h*0.012,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(h*0.010),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                  offset: Offset(0, 0), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Card(
                              color: Colors.transparent,
                              elevation: 0,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(h*0.025,h*0.020,h*0.025,h*0.020),
                                child: Column(
                                  children: [
                                    Container(
                                      width: h*0.070,
                                      height: h*0.070,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage('assets/images/symptome-4.png'),
                                            fit: BoxFit.fill
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: h*0.010,
                                    ),
                                    Container(
                                      width: h*0.1,
                                      child: Text(
                                        "Perte de goût ou d'odeur",
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w100,
                                          fontSize: h*0.012,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(h*0.010),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                  offset: Offset(0, 0), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Card(
                              color: Colors.transparent,
                              elevation: 0,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(h*0.025,h*0.020,h*0.025,h*0.020),
                                child: Column(
                                  children: [
                                    Container(
                                      width: h*0.070,
                                      height: h*0.070,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: AssetImage('assets/images/symptome-6.png'),
                                            fit: BoxFit.fill
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: h*0.010,
                                    ),
                                    Container(
                                      width: h*0.1,
                                      child: Text(
                                        "Difficulté à respirer",
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w100,
                                          fontSize: h*0.012,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
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
                      fontSize:10,
                    ),
                  ),
                )
              ],
            )
        ),
      );
    } else
      wrapContent=maintenance();
      return SafeArea(child:  wrapContent);
  }
}
