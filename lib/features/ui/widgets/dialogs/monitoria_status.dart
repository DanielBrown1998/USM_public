part of 'all_dialog.dart';

Future<dynamic> alertDialogStatusMonitoria(
  BuildContext context, {
  required Monitoria monitoriaMarcada,
  required IconData icon,
  required String title,
  required String description,
  required String confirmation,
  required String cancel,
  bool monitoriaOk = true,
}) {
  MonitoriaController monitoria =
      Provider.of<MonitoriaController>(context, listen: false);
  final theme = Theme.of(context);

  return showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        icon: Icon(icon),
        elevation: 20,
        backgroundColor: theme.primaryColor,
        title: Text(
          title,
          style: theme.textTheme.bodyLarge,
        ),
        content: Text(
          description,
          style: theme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
              onPressed: () async {
                try {
                  Monitoria? monitoriaUpdated =
                      await monitoria.updateStatusMonitoria(
                          monitoria: monitoriaMarcada,
                          newStatus:
                              (monitoriaOk) ? Status.presente : Status.ausente);
                  if (!dialogContext.mounted) return;
                  Navigator.pop(dialogContext, monitoriaUpdated);
                } on StatusMOnitoriaException catch (e) {
                  Navigator.pop(dialogContext, e.message);
                } catch (e) {
                  Navigator.pop(dialogContext, e.toString());
                }
              },
              child: Text(
                confirmation,
                style: TextStyle(color: theme.cardColor, fontSize: 15),
              )),
          TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: Text(
                cancel,
                style: TextStyle(color: theme.cardColor, fontSize: 15),
              )),
        ],
      );
    },
  );
}
