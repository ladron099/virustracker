import 'package:CovidTracker/resources/submitButton.dart';
import 'package:flutter/material.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../resources/color.dart';

class shareScreen extends StatefulWidget {
  const shareScreen({Key? key}) : super(key: key);

  @override
  _shareScreenState createState() => _shareScreenState();
}

class _shareScreenState extends State<shareScreen> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(top: h*0.2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/share.png",
                width: h*0.35,
              ),
              Padding(
                  padding: EdgeInsets.all(h*0.040),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(h*0.010),
                        child: Text(
                          "Plus nous sommes nombreux à utiliser VIRUS TRACKER et mieux nous sommes protégès.",
                          style: TextStyle(
                            color: ybcolor,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w900,
                            fontSize: h*0.018,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      Text(
                        "Nous avons besoin de vous: l'impact de cette application dans la lutte contre le VIRUS dépend de vous! Merci de la partager avec vos proches.",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w100,
                          fontSize: h*0.015,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                          padding: EdgeInsets.only(top:h*0.040),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                submitButton(
                                  text: 'Partager l\'application',
                                  press: (){
                                     },
                                  textColor: Colors.white,
                                  color: ybcolor,
                                ),
                                SizedBox(
                                  height: h*0.020,
                                ),
                              ])
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
