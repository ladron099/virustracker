import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class errorMessage extends StatefulWidget {
  final String errorText;
  const errorMessage(this.errorText) ;

  @override
  _errorMessageState createState() => _errorMessageState(errorText);
}

class _errorMessageState extends State<errorMessage> {
  String errorText;
  _errorMessageState( this.errorText);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return  SizedBox(
      child: Container(
        child: Padding(
          padding: EdgeInsets.only(top:h*0.01),
          child: Text(errorText,
            style: TextStyle(
              color: Colors.red,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
      ),
    );
  }
}
