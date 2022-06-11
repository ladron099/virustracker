import 'package:flutter/material.dart';

bool bluetooth = true;

class switchState extends StatelessWidget {
  late bool state;

  switchState({
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    if (state) {
      return Text(
        'Service Activé',
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
      );
    } else
      return Text(
        'Service Désactivé',
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
      );
  }
}
