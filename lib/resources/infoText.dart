import 'package:flutter/cupertino.dart';

class infoText extends StatelessWidget {
  final String text;
  final double size;
  const infoText({Key? key, required this.text, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Container(
              child: Text(
                text,
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: size,
                ),
                textAlign: TextAlign.center,
              ),
              width: 500,
              height: 25,
            ),
          ),
        ],
      ),
    );
  }
}
