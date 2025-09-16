import 'package:flutter/material.dart';

class FormatForm extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  const FormatForm(
      {super.key, required this.width, this.height = 100, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(
          minHeight: 70,
          maxHeight: 100,
          minWidth: 230,
          maxWidth: 600,
        ),
        height: height,
        width: width,
        child: Center(child: child));
  }
}
