import 'package:app/features/controllers/user_controllers.dart';
import 'package:app/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:app/core/theme/theme.dart';

class ListTileWidget extends StatelessWidget {
  final IconData iconName;
  final Color iconColor;
  final String text;
  final Color splashColor;
  const ListTileWidget(
      {super.key,
      required this.iconName,
      required this.iconColor,
      required this.text,
      required this.splashColor});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: FittedBox(child: Icon(iconName, color: iconColor)),
      title: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
          style: theme.textTheme.displaySmall,
        ),
      ),
      splashColor: splashColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}

class ListDrawer {
  static Drawer list(BuildContext context, {required UserController user}) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);

    List<Widget> listWidgets = [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              color: ThemeUSM.whiteColor,
              key: Key("back_drawer"),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_outlined)),
        ],
      ),
      DrawerHeader(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: size.height * 0.05,
              width: size.width * .4,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/back-720.png"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Image.asset(
                      "assets/images/logomarca-uerj.png",
                      height: 50,
                      width: 50,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "MONITORIA",
                        style: theme.textTheme.displaySmall,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Icon(
                      Icons.account_circle_outlined,
                      size: 30,
                      color: ThemeUSM.whiteColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "${user.user!.firstName} ${user.user!.lastName}",
                      style: theme.textTheme.displaySmall,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      ListTileWidget(
        iconName: Icons.search,
        iconColor: ThemeUSM.whiteColor,
        text: "Alunos",
        splashColor: ThemeUSM.backgroundColorWhite,
      ),
      ListTileWidget(
        iconName: Icons.assignment_ind_outlined,
        iconColor: ThemeUSM.whiteColor,
        text: "Monitoria",
        splashColor: ThemeUSM.backgroundColorWhite,
      ),
      ListTileWidget(
        iconName: Icons.receipt_long_sharp,
        iconColor: ThemeUSM.whiteColor,
        text: "Relatorios",
        splashColor: ThemeUSM.backgroundColorWhite,
      ),
      ListTileWidget(
        iconName: Icons.settings_applications_outlined,
        iconColor: ThemeUSM.whiteColor,
        text: "Configuracoes",
        splashColor: ThemeUSM.backgroundColorWhite,
      ),
      ListTileWidget(
        iconName: Icons.volunteer_activism_outlined,
        iconColor: ThemeUSM.whiteColor,
        text: "Sobre",
        splashColor: ThemeUSM.backgroundColorWhite,
      ),
      InkWell(
        onTap: () async {
          Navigator.popAndPushNamed(context, Routes.logout);
        },
        child: ListTileWidget(
          iconName: Icons.exit_to_app_outlined,
          iconColor: ThemeUSM.whiteColor,
          text: "Sair",
          splashColor: ThemeUSM.purpleUSMColor,
        ),
      ),
    ];

    return Drawer(
      width: size.width * .5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int i) => Divider(
            color: theme.dividerColor,
          ),
          itemCount: listWidgets.length,
          itemBuilder: (BuildContext context, int i) {
            return listWidgets[i];
          },
        ),
      ),
    );
  }
}
