import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';

import '../screens/landing.dart';
import '../screens/offline.dart';
import '../screens/register.dart';

class conn extends StatelessWidget {
  final Widget clas;

  const conn({Key? key, required this.clas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool connected;
    return OfflineBuilder(
        connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
            ) {
          Widget wrapContent = Text('');
          connected = connectivity != ConnectivityResult.none;


          connected ? wrapContent = clas : wrapContent = offline();
          return wrapContent;
        },
        builder: (BuildContext context) {
          return register();
        },
      );

  }
}
