// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class Pixel extends StatelessWidget {
  var color;
  var child;
  Pixel({
    super.key,
    required this.color,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
        margin: const EdgeInsets.all(1),
        child: const Center());
  }
}
