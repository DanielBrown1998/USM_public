import 'package:app/core/theme/theme.dart';
import 'package:flutter/material.dart';

class ConfigCard extends StatelessWidget {
  final String route;
  final String titleText;
  final String description;
  final IconData icon;
  const ConfigCard(
      {super.key,
      required this.route,
      required this.titleText,
      required this.description,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      leading: Icon(icon),
      title: Text(titleText, style: USMThemeText.textTheme.displayMedium),
      subtitle: Text(description, style: USMThemeText.textTheme.displaySmall),
    );
  }
}
