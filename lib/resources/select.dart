import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'color.dart';

class select extends StatefulWidget {

  const select({Key? key}) : super(key: key);

  @override
  _selectState createState() => _selectState();
}


class _selectState extends State<select> {
  String holder = '' ;
  late String newValue="homme";
  void getDropDownItem(){

    setState(() {
      holder = newValue ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: DecoratedBox(

        decoration: BoxDecoration(

            color:Colors.white, //background color of dropdown button
            border: Border.all(color: ybcolor, width:2), //border of dropdown button
            borderRadius: BorderRadius.circular(50), //border raiuds of dropdown button
            boxShadow: <BoxShadow>[ //apply shadow on Dropdown button
             //blur radius of shadow
            ]
        ),

        child:Padding(
            padding: EdgeInsets.only(left:30, right:30),
            child:DropdownButton(
              hint: Text('Genre'),
              value: newValue,
              items: [ //add items in the dropdown
                DropdownMenuItem(
                  child: Text("Homme"),
                  value: "homme",
                ),
                DropdownMenuItem(
                    child: Text("Femme"),
                    value: "femme"
                ),


              ],
          onChanged: (value) => setState(() {
          newValue=  "$value";
            getDropDownItem();
          }),
              icon: Padding( //Icon at tail, arrow bottom is default icon
                  padding: EdgeInsets.only(left:20),
                  child:Icon(Icons.arrow_circle_down_sharp)
              ),
              iconEnabledColor: ybcolor, //Icon color
              style: TextStyle(
                  color:Colors.grey,fontFamily: 'Montserrat', //Font color
                  fontSize: 16 //font size on dropdown button
              ),

              dropdownColor: Colors.white, //dropdown background color
              underline: Container(), //remove underline
              isExpanded: true, //make true to make width 100%
            )
        )
    ) );


  }
}
