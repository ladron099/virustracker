import 'package:CovidTracker/resources/submitButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import '../resources/color.dart';
import '../resources/infoText.dart';

class declareScreen extends StatefulWidget {
  const declareScreen({Key? key}) : super(key: key);

  @override
  _declareScreenState createState() => _declareScreenState();
}

class _declareScreenState extends State<declareScreen> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(top: h*0.150),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/declarer.png",
                width: h*0.35,
              ),
              Padding(
                  padding: EdgeInsets.all(h*0.04),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(h*0.01),
                        child: Text(
                          "Vous avez fait un test d'un virus et il est positif?",
                          style: TextStyle(
                            color: ybcolor,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w900,
                            fontSize: 17,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      Text(
                        "Votre médecin ou laboratoire vous a remis un code: merci de le rentrer pour que les personnes que vous avez croisées soient alértées. Prenez soin de vous!",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w100,
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.center,
                      ),
                     Padding(
                         padding: EdgeInsets.only(top:h*0.06),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         submitButton(
                         text: 'Scanner le code QR',
                         press: (){
                         },
                         textColor: Colors.white,
                         color: ybcolor,
                       ),
                         SizedBox(
                           height: h*0.02,
                         ),
                         Container(
                           width: double.infinity,
                           child: InkWell(
                             splashColor: ybcolorOp,
                             child: OutlineGradientButton(
                               child: GradientText(
                                 'Saisir le code',
                                 style: TextStyle(
                                   fontFamily: 'Montserrat',
                                   fontWeight: FontWeight.w100,
                                 ),
                                 textAlign: TextAlign.center,
                                 colors: [
                                   ybcolor2,ybcolor
                                 ],
                               ),
                               gradient: gradientcolor,
                               strokeWidth: 2,
                               radius: Radius.circular(25),
                               padding: EdgeInsets.symmetric(horizontal: h*0.04, vertical:h*0.02),
                               onTap:  () {
                               },
                             ),
                           ),
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
