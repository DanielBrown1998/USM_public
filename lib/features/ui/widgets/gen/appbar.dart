import 'package:app/core/routes/routes.dart';
import 'package:app/core/theme/theme.dart';
import 'package:flutter/material.dart';

class USMAppBar {
  static AppBar appBar(BuildContext context, String title,
      {bool hasDrawer = false, bool leading = false}) {
    return AppBar(
      leading: (leading || hasDrawer)
          ? Builder(builder: (context) {
              return hasDrawer
                  ? IconButton(
                      icon: const Icon(Icons.menu),
                      tooltip: MaterialLocalizations.of(context)
                          .openAppDrawerTooltip,
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    )
                  : IconButton(
                      key: Key("back_button_appbar"),
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    );
            })
          : null,
      actions: [
        Hero(
          tag: "account",
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.userScreen);
              },
              icon: Icon(Icons.account_box_outlined),
            ),
          ),
        ),
        IconButton(
            onPressed: () async {
              Navigator.popAndPushNamed(context, Routes.logout);
            },
            icon: Icon(Icons.logout_outlined, color: ThemeUSM.purpleUSMColor)),
      ],
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}
