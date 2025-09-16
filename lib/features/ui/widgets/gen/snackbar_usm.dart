import 'package:app/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void showSnackBarUSM(BuildContext context, String lottieURL, String message) {
  final theme = Theme.of(context);
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    padding: EdgeInsets.all(16),
    backgroundColor: ThemeUSM.blackColor,
    showCloseIcon: true,
    elevation: 10,
    shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: ThemeUSM.purpleUSMColor, width: 4)),
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
            flex: 2, child: Lottie.asset(lottieURL, width: 75, height: 75)),
        Flexible(
            flex: 3,
            child: Text(
              message,
              style: theme.primaryTextTheme.displaySmall,
            )),
      ],
    ),
    duration: Duration(seconds: 2),
  ));
}
