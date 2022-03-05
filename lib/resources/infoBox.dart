import 'package:flutter/material.dart';

import 'color.dart';

class infoBox extends StatelessWidget {
  final String mainText;
  final Color textColor;
  final String image;
  final String desc;
  final Color shadowColor;
  final Function onPressed;

  const infoBox({
    required this.mainText,
    required this.textColor,
    required this.desc,
    required this.image,
    required this.shadowColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 25, left: 30, right: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: this.shadowColor,
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        child: Card(
            elevation: 0,
            color: Colors.transparent,
            child: InkWell(
              splashColor: ybcolorOp,
              onTap: (){
                onPressed();
              },
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 15, 10, 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            mainText,
                            style: TextStyle(
                              color: this.textColor,
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
                            desc,
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
                        Image.asset(image, width: 80),
                      ],
                    ),
                  ],
                ),
              ),
            )));
  }
}
