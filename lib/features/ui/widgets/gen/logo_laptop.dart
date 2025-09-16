import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LogoLaptop extends StatelessWidget {
  const LogoLaptop({super.key});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "lottie-laptop",
      child: Lottie.asset("assets/loties/laptop.json"),
    );
  }
}
