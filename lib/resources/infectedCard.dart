import 'package:flutter/material.dart';
import '../utils/color.dart';



class infectedCard extends StatelessWidget {
  final bool infected;
  const infectedCard({
    required this.infected,
  });

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    if(!infected){
      return Container(
        margin: EdgeInsets.only(left: 30, right: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.indigo.withOpacity(0.2),
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
            padding: EdgeInsets.fromLTRB(h*0.025,h*0.020,h*0.025,h*0.040),
            child: Column(
              children: [
                Image.asset('assets/images/usershield.png', width: 80),
                SizedBox(
                  height: h*0.020,
                ),
                Text(
                  "Aucune exposition detectée",
                  style: TextStyle(
                    color: ybcolor,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w900,
                    fontSize: h*0.017,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: h*0.015,
                ),
                Text(
                  "Vous n'avez pas été près de quelqu'un qui a signalé un diagnostic du virus via cette application",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w100,
                    fontSize: h*0.013,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          )
        ),
      );
    }else
      return Container(
        margin: EdgeInsets.only(left: 35, right: 35),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.1),
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
              padding: EdgeInsets.fromLTRB(h*0.020,h*0.010,h*0.020,h*0.030),
              child: Column(
                children: [
                  Image.asset('assets/images/usershieldred.png', width: 80),
                  SizedBox(
                    height: h*0.020,
                  ),
                  Text(
                    "Attention: Exposition detectée",
                    style: TextStyle(
                      color: Colors.red,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w900,
                      fontSize: h*0.017,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: h*0.015,
                  ),
                  Text(
                    "L’application a detectée que vous avez croisé quelqu'un contaminé .",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w100,
                      fontSize: h*0.014,
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            )
        ),
      );
  }
}
