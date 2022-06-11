import 'package:CovidTracker/resources/infoBox.dart';
import 'package:flutter/material.dart';
import '../screens/Exposition.dart';
import '../screens/noExposition.dart';
import '../utils/color.dart';

class exposureBox extends StatelessWidget {
    final bool exposure;
  const exposureBox({
    required this.exposure,
  });

  @override
  Widget build(BuildContext context) {
    if(exposure){
      return infoBox(
        textColor: Colors.red,
        mainText: "Attention: Exposition detectée",
        desc:
        "Vous avez croisé quelqu'un contaminé. Veuillez cliquez sur cette carte pour vous renseigner.",
        image: "assets/images/usershieldred.png",
        shadowColor: Colors.red.withOpacity(0.1),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Exposition()));
        },
      );
    }else
      return infoBox(
        textColor: ybcolor,
        mainText: "Aucune exposition detectée",
        desc:
        "Vous n'avez pas été près de quelqu'un qui a signalé un diagnostic d' un virus via cette application. Cliquez pour plus d'informations.",
        image: "assets/images/usershield.png",
        shadowColor: Colors.indigo.withOpacity(0.2),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => noExposition()));
        },
      );
  }
}
