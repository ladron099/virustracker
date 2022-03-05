import 'package:flutter/material.dart';

import '../DAL/authService.dart';
import '../screens/landing.dart';
import '../screens/settings.dart';
import 'color.dart';

class respBar extends StatelessWidget {
  final int type;
  respBar({
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    if (type == 0) {
      return Padding(
        padding: EdgeInsets.only(top: 20),
        child: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => settingsScreen()));
                    // _auth.signout();
                },
                icon: Icon(Icons.settings_rounded))
          ],
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            padding: EdgeInsets.only(left: 5, top: 10),
            child: Row(children: [
              Image.asset(
                "assets/images/whiteLOGO.png",
                width: 170,
              )
            ]),
          ),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(top: 20),
        child: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => settingsScreen()));
              },
              icon: Icon(Icons.settings_rounded), color: ybcolor,)
          ],
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            padding: EdgeInsets.only(left: 5, top: 10),
            child: Row(children: [
              Image.asset(
                "assets/images/gradientLOGO.png",
                width: 170,
              )
            ]),
          ),
        ),
      );
    }
  }
}