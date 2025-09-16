part of 'all_dialog.dart';

Future<dynamic> alertDialogStudent(
  BuildContext context, {
  required IconData icon,
  required String title,
  required String msg,
  required String confirmation,
}) {
  final theme = Theme.of(context);
  AlertDialog alert = AlertDialog(
    icon: Icon(icon),
    elevation: 20,
    backgroundColor: theme.primaryColor,
    title: Text(
      title,
      style: TextStyle(color: theme.dividerColor, fontSize: 20),
    ),
    content: Text(msg),
    actions: [
      TextButton(
          onPressed: () {
            Navigator.pop(context, null);
          },
          child: Text(
            confirmation,
            style: TextStyle(color: theme.cardColor, fontSize: 15),
          )),
      // TextButton(
      //     onPressed: () {
      //       Navigator.pop(context, false);
      //     },
      //     child: Text(
      //       cancel,
      //       style: TextStyle(color: theme.cardColor, fontSize: 15),
      //     )),
    ],
  );

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
