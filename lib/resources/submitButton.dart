import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'color.dart';

class submitButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color;
  final Color textColor;

  const submitButton({
    required this.text,
    required this.press,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {

    return
        Container(
          decoration: BoxDecoration(
          gradient: gradientcolor,
            borderRadius: new BorderRadius.circular(50.0),
          ),
          child:
            new SizedBox(
              width: 350,
              height: 50,
                child: MaterialButton(
                  highlightColor: ybcolor,
                  shape: StadiumBorder(),
                  textColor: textColor,
                  child: Text(text,
                    style:
                    TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  onPressed: () {press();},
                ),
              ),
        );
  }
}
