import 'package:CovidTracker/resources/infoBox.dart';
import 'package:CovidTracker/screens/declareScreen.dart';
import 'package:flutter/material.dart';

import 'color.dart';

class infectedBox extends StatelessWidget {
    final bool infected;

  const infectedBox({
    required this.infected,
  });

  @override
  Widget build(BuildContext context) {
    if(infected){
      return infoBox(
        textColor: Colors.red,
        mainText: "Attention: Exposition detectée",
        desc:
        "Vous avez croisé quelqu'un contaminé. Veuillez cliquez sur cette carte pour vous renseigner.",
        image: "assets/images/usershieldred.png",
        shadowColor: Colors.red.withOpacity(0.1),
        onPressed: () {
          MaterialPageRoute(builder: (context) => declareScreen());
        },
      );
    }else
      return infoBox(
        textColor: ybcolor,
        mainText: "Aucune exposition detectée",
        desc:
        "Vous n'avez pas été près de quelqu'un qui a signalé un diagnostic d' un virus via cette application",
        image: "assets/images/usershield.png",
        shadowColor: Colors.indigo.withOpacity(0.2),
        onPressed: () {},
      );
  }
}
