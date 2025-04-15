import 'package:flutter/material.dart';
import 'package:voitureRoyale/configs/mycolors.dart';

Widget myButton(VoidCallback work, {required label, color = mainColor}) {
  return MaterialButton(
    onPressed: work,
    color: color,
    minWidth: 300,
    child: Text(label),
    textColor: Colors.white,
  );
}
