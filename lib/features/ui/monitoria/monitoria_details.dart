import 'package:app/domain/models/monitoria.dart';
import 'package:app/core/theme/theme.dart';
import 'package:flutter/material.dart';

class MonitoriaDetails extends StatelessWidget {
  final Monitoria monitoria;
  const MonitoriaDetails({super.key, required this.monitoria});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: ThemeUSM.blackColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ListTile(
          leading: FittedBox(
            fit: BoxFit.scaleDown,
            child: CircleAvatar(
              backgroundColor: ThemeUSM.backgroundColorWhite,
              child: Icon(
                Icons.person,
                color: ThemeUSM.blackColor,
              ),
            ),
          ),
          title: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              monitoria.aluno,
              style: theme.primaryTextTheme.displayMedium!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          subtitle: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
                "${monitoria.date.day}/${monitoria.date.month}/${monitoria.date.year}",
                style: theme.textTheme.displaySmall),
          ),
          trailing: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text("status: ${monitoria.status}",
                style: theme.textTheme.displaySmall),
          ),
          onTap: () {}, // TODO create dialog for change status here
        ),
      ),
    );
  }
}
