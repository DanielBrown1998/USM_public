import 'package:app/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class USMSnackBarContent extends StatelessWidget {
  final String message;
  final bool success;
  const USMSnackBarContent(
      {super.key, required this.message, this.success = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeUSM.blackColor,
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Lottie.asset(
              (success)
                  ? 'assets/loties/success.json'
                  : 'assets/loties/error.json',
              width: 36,
              height: 36,
              fit: BoxFit.cover,
            ),
          ),
          // Icon(Icons.check_circle, color: ThemeUSM.whiteColor),
          Spacer(flex: 1),
          Expanded(
            flex: 8,
            child: Text(
              message,
            ),
          ),
        ],
      ),
    );
  }
}
