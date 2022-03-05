import 'package:flutter/material.dart';

const ybcolor = Color(0xFF5A58C3);
const ybcolorOp = Color(0x4B5A58C3);
const ybcolor2 = Color(0xFF73BEE0);
const ybcolor3 = Color(0xFF68B8DD);
const gradientcolor = LinearGradient(
colors: [
  Color(0xFF73BEE0),
  Color(0xFF5A58C3),
],
  begin: FractionalOffset(0.0, 0.0),
  end: FractionalOffset(0.5, 0.0),
  stops: [0.0, 1.0],
  tileMode: TileMode.clamp
);
const boxgradient = LinearGradient(
    colors: [
      Color(0xFF73BEE0),
      Color(0xFF5A58C3),
    ],
    begin: FractionalOffset(0.0, 0.0),
    end: FractionalOffset(0.4, 1.0),
    stops: [0.0, 1.0],
    tileMode: TileMode.clamp
);