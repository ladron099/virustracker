import 'package:flutter/material.dart';
import '../models/slide.dart';

class bienvenueItem extends StatelessWidget {
  final int index;
  bienvenueItem(this.index);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: h*0.030),
          child: Image.asset(
            slide.slideList[index].image,
            width: h*0.400,
            height: h*0.240,
          ),
        ),
        slide.slideList[index].title,
         Container(
            child: Text(
              slide.slideList[index].desc,
              style: TextStyle(
                fontFamily: "Montserrat",
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w100,
                fontSize: h*0.016,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
              softWrap: true,
            ),
           constraints: BoxConstraints(
             maxHeight: double.infinity,
             maxWidth: h*0.350,
           ),
          ),
      ],
    );
  }
}
