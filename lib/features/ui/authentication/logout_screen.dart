import 'package:app/features/controllers/user_controllers.dart';
import 'package:app/core/routes/routes.dart';
import 'package:app/core/theme/theme.dart';
import 'package:app/features/ui/widgets/gen/logo_laptop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogoutScreen extends StatelessWidget {
  const LogoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        color: ThemeUSM.purpleUSMColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LogoLaptop(),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    "Deseja Realizar Logout?",
                    style: theme.textTheme.displayLarge,
                    overflow: TextOverflow.visible,
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                elevation: 10,
                alignment: Alignment.center,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: theme.primaryColor, width: 2),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                minimumSize: Size(size.width * 0.3, size.height * 0.06),
                maximumSize: Size(size.width * 0.6, size.height * 0.06),
                backgroundColor: ThemeUSM.purpleUSMColor,
              ),
              onPressed: () {
                Navigator.popAndPushNamed(context, Routes.home);
              },
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  "Nao, voltar",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: ThemeUSM.whiteColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          UserController userProvider =
              Provider.of<UserController>(context, listen: false);
          await userProvider.logout();
          if (!context.mounted) return;
          Navigator.popAndPushNamed(context, Routes.login);
        },
        label: FittedBox(fit: BoxFit.contain, child: Text("Logout")),
        icon: Icon(Icons.logout),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}
