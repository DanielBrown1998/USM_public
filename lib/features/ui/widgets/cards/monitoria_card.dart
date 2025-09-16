import 'package:app/features/ui/widgets/dialogs/all_dialog.dart';
import 'package:app/domain/models/monitoria.dart';
import 'package:app/core/theme/theme.dart';
import 'package:flutter/material.dart';

class MonitoriaCard extends StatelessWidget {
  final Monitoria monitoria;
  const MonitoriaCard({super.key, required this.monitoria});

  @override
  Widget build(BuildContext context) {
    final messenger = ScaffoldMessenger.of(context);
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 2.0, right: 2.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      monitoria.userName,
                      style: theme.primaryTextTheme.bodyLarge,
                    ),
                  ),
                  Row(
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "${monitoria.date.day}-${monitoria.date.month}-${monitoria.date.year}",
                          style: theme.primaryTextTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                //confirmation button
                IconButton(
                  onPressed: () async {
                    dynamic value = await alertDialogStatusMonitoria(context,
                        icon: Icons.dangerous_outlined,
                        title: "Alterar Status Monitoria",
                        confirmation: "sim",
                        cancel: "nao",
                        description:
                            "deseja alterar o status da msg para realizado",
                        monitoriaMarcada: monitoria);
                    if (value is Monitoria) {
                      messenger.showSnackBar(SnackBar(
                          content: FittedBox(
                        fit: BoxFit.scaleDown,
                        child:
                            Text("${monitoria.userName} realizou a monitoria!"),
                      )));
                    } else if (value == null) {
                      messenger.showSnackBar(SnackBar(
                          content: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                            " status nao alterado para ${monitoria.userName}"),
                      )));
                    } else {
                      messenger.showSnackBar(SnackBar(
                          content: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text("Erro: ${value.toString()}"))));
                    }
                  },
                  icon: Icon(Icons.check, color: ThemeUSM.whiteColor),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeUSM.blackColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                //no confirmation button
                IconButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).dividerColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  icon:
                      Icon(Icons.delete, color: Theme.of(context).primaryColor),
                  onPressed: () async {
                    dynamic value = await alertDialogStatusMonitoria(context,
                        icon: Icons.dangerous_outlined,
                        title: "Alterar Status Monitoria",
                        confirmation: "sim",
                        cancel: "nao",
                        description:
                            "deseja alterar o status da msg para nao realizado",
                        monitoriaMarcada: monitoria,
                        monitoriaOk: false);
                    if (value is Monitoria) {
                      messenger.showSnackBar(SnackBar(
                          content: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                            " ${monitoria.userName} nao realizou a monitoria"),
                      )));
                    } else if (value == null) {
                      messenger.showSnackBar(SnackBar(
                          content: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                            " status nao alterado para ${monitoria.userName}"),
                      )));
                    } else {
                      messenger.showSnackBar(
                          SnackBar(content: Text("Erro: ${value.toString()}")));
                    }
                  },
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}
