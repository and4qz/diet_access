// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class StarWidget extends StatelessWidget {
  final int total;
  final int activated;

  const StarWidget({Key? key, this.total = 5, required this.activated})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(total, (index) {
        var filled = index < activated;
        return Icon(
          filled ? Icons.star : Icons.star_border,
          color: Color(0xff023341),
        );
      }).toList(),
    );
  }
}
