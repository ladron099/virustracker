import 'package:CovidTracker/resources/infectedCard.dart';
import 'package:CovidTracker/screens/maintenance.dart';
import 'package:flutter/material.dart';
import '../utils/color.dart';


class Exposition extends StatefulWidget {
  const Exposition({Key? key}) : super(key: key);

  @override
  State<Exposition> createState() => _ExpositionState();
}

class _ExpositionState extends State<Exposition> {
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
                "Exposition",
                style: TextStyle(
                  color: Colors.red,
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
                color: Colors.red,
              ),
            ),
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                infectedCard(infected: true),
                Padding(
                    padding: EdgeInsets.fromLTRB(h*0.045,h*0.025,h*0.045,0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Que faire maintenant ?",
                            style: TextStyle(
                              color: Colors.red,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              fontSize: h*0.02,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            height: h*0.010,
                          ),
                          Text(
                            "Vous avez reçu une alerte parceque vous avez étez en contact avec quelqu’un qui a été testé positif au virus. \n"
                                "\nIl peut également y avoir un risque que vous développiez le virus, vous devez donc vous mettre en quarantaine à la maison, parler à votre médecin et vous concentrer sur votre santé pour vous protéger et protéger les autres.",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w100,
                              fontSize: h*0.012,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ])
                ),
                Padding(
                  padding: EdgeInsets.all(h*0.030),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only( left:10, right: 10),
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
                              elevation: 0,
                              color: Colors.transparent,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(20, 15, 10, 20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            'Faites un test du virus ',
                                            style: TextStyle(
                                              color: ybcolor,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w900,
                                              fontSize: 17,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Nous vous recommandons de faire un test de dépistage du virus pour être sûr de votre exposition.",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w100,
                                              fontSize: 10,
                                            ),
                                            textAlign: TextAlign.left,
                                          )
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: h*0.1,
                                          height: h*0.09,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: AssetImage('assets/images/test.png'),
                                                fit: BoxFit.fill
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ))),
                      //end of first card test
                      Container(
                          margin: EdgeInsets.only(top:20, left:10, right: 10),
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
                              elevation: 0,
                              color: Colors.transparent,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(20, 15, 10, 20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Text(
                                            'Gardez un œil sur votre température',
                                            style: TextStyle(
                                              color: ybcolor,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w900,
                                              fontSize: 17,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Surveillez votre température corporelle et appelez l'hôpital si vous ne vous sentez pas bien.",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.w100,
                                              fontSize: 10,
                                            ),
                                            textAlign: TextAlign.left,
                                          )
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: h*0.1,
                                          height: h*0.09,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: AssetImage('assets/images/temp.png'),
                                                fit: BoxFit.fill
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )))
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
