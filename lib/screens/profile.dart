import 'package:cointacao/stores/user_store.dart';
import 'package:cointacao/utils/routes.dart';
import 'package:cointacao/widgets/appbar_widget.dart';
import 'package:cointacao/widgets/button_widget.dart';
import 'package:cointacao/widgets/info_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    final store = Provider.of<UserStore>(context);

    return Scaffold(
      appBar: const AppBarWidget(
        title: "Perfil",
      ),
      backgroundColor: colorScheme.secondaryContainer,
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Container(
          padding: const EdgeInsets.all(32.0),
          decoration: BoxDecoration(
            color: colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoWidget(label: "Nome", value: store.user?.name),
                  InfoWidget(label: "E-mail", value: store.user?.email),
                  InfoWidget(label: "Celular", value: store.user?.phone),
                  InfoWidget(
                      label: "Data de Nascimento", value: store.user?.birthday),
                  InfoWidget(
                      label: "Moedas Favoritadas",
                      value: store.user?.coins.join(", ")),
                ],
              ),
              const Spacer(),
              CustomButton(
                text: "Sair",
                type: "primary",
                onPressed: () {
                  store.authRepository.signOut();
                  Navigator.pushNamed(context, AppRoutes.login);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
