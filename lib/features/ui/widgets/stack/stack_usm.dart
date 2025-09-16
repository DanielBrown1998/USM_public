import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class StackUSM extends StatelessWidget {
  final Widget child;
  const StackUSM({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: 'background',
          child: Lottie.asset(
            'assets/loties/back.json',
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        child,
      ],
    );
  }
}
