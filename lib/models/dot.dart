import 'package:flutter/material.dart';

class dot extends StatelessWidget {
  final bool _selected;

  dot(this._selected);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(3.5),
      width: _selected ? 17 : 14,
      height:  _selected ? 17 : 14,
      child: MaterialButton(
        elevation: 0,
        onPressed: (){},
        color: _selected ? Color(0xFF5A58C3) : Colors.grey[400],
        shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(100),
        ),
      ),
    );
  }
}