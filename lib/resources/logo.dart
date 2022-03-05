import 'package:flutter/cupertino.dart';

class logo extends StatelessWidget {
  const logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Image.asset("assets/images/logoVT.png",
            width: h*0.220,
            fit:BoxFit.fitWidth,),

      ],
    );
  }
}
