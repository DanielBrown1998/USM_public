import 'package:app/domain/models/user.dart';
import 'package:app/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class UserCard extends StatelessWidget {
  final String? photoURL;
  final User user;
  final auth.User? currentUser;
  const UserCard(
      {super.key, required this.user, this.currentUser, this.photoURL});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      key: Key(user.uid),
      elevation: 20,
      color: ThemeUSM.blackColor,
      shadowColor: theme.colorScheme.onPrimaryContainer,
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.onPrimaryContainer,
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      photoURL != null
                          ? CircleAvatar(
                              radius: 60,
                              child: Image.network(photoURL!),
                            )
                          : CircleAvatar(radius: 60, child: Text("no-image")),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        spacing: 5,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              textAlign: TextAlign.right,
                              "${user.firstName} ${user.lastName}",
                              style:
                                  theme.primaryTextTheme.displayLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              user.userName,
                              textAlign: TextAlign.right,
                              style: theme.primaryTextTheme.displaySmall,
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              user.phone,
                              textAlign: TextAlign.right,
                              style: theme.primaryTextTheme.displaySmall,
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              user.campus,
                              textAlign: TextAlign.right,
                              style: theme.primaryTextTheme.displaySmall,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  //email field
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        user.email,
                        textAlign: TextAlign.right,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        style: theme.primaryTextTheme.displaySmall,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  (currentUser != null && user.uid == currentUser!.uid)
                      ? Wrap(
                          direction: Axis.horizontal,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          runAlignment: WrapAlignment.start,
                          spacing: 5,
                          runSpacing: 5,
                          children: [
                              Material(
                                color: theme.colorScheme.onPrimaryContainer,
                                shape: Border.all(
                                  width: 1,
                                  style: BorderStyle.solid,
                                  color: theme.primaryColor,
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: InkWell(
                                  splashColor: theme.splashColor,
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "Alterar imagem perfil",
                                        style:
                                            theme.primaryTextTheme.displaySmall,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Material(
                                color: theme.colorScheme.onPrimaryContainer,
                                shape: Border.all(
                                  width: 1,
                                  style: BorderStyle.solid,
                                  color: theme.primaryColor,
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: InkWell(
                                  splashColor: theme.splashColor,
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "Alterar senha",
                                        style:
                                            theme.primaryTextTheme.displaySmall,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Material(
                                color: theme.colorScheme.onPrimaryContainer,
                                shape: Border.all(
                                  width: 1,
                                  style: BorderStyle.solid,
                                  color: theme.primaryColor,
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: InkWell(
                                  splashColor: theme.splashColor,
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "Aualizar dados",
                                        style:
                                            theme.primaryTextTheme.displaySmall,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ])
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "E-MAIL: ",
                                  style: theme.textTheme.displaySmall,
                                ),
                              ),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  user.email,
                                  textAlign: TextAlign.right,
                                  softWrap: true,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: theme.primaryTextTheme.displaySmall,
                                ),
                              ),
                            ]),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 5,
              runSpacing: 5,
              alignment: WrapAlignment.spaceEvenly,
              crossAxisAlignment: WrapCrossAlignment.end,
              children: [
                (currentUser != null)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'E-mail verificado: ',
                              style: theme.primaryTextTheme.displaySmall,
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Icon(
                              Icons.circle,
                              color: currentUser!.emailVerified
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ],
                      )
                    : SizedBox.shrink(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text("Usuario ativo?",
                          style: theme.primaryTextTheme.displaySmall),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Icon(
                        Icons.circle,
                        color: (!user.isActive) ? Colors.red : Colors.green,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "Disciplinas disponiveis;",
                style: theme.primaryTextTheme.displaySmall,
                textAlign: TextAlign.start,
              ),
            ),
          ),
          Divider(
            color: theme.colorScheme.onPrimaryContainer,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 5,
              alignment: WrapAlignment.spaceEvenly,
              children: List<Widget>.generate(
                user.disciplinas.length,
                (index) {
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: theme.colorScheme.onPrimaryContainer),
                        borderRadius: BorderRadius.circular(4)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4.0, vertical: 2.0),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          user.disciplinas[index].nome,
                          style: theme.primaryTextTheme.displaySmall,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
