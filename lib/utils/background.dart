import 'package:flutter/cupertino.dart';

class background extends StatelessWidget {
  final String path;

  const background({Key? key, required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Image.asset(
            path,
            height: 260,
            width: 260,
            fit: BoxFit.fitWidth,
          ),
        ),
      ],
    );
  }
}
