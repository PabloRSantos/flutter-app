import 'package:cointacao/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: const AppBarWidget(
        title: "Favoritos",
      ),
      backgroundColor: colorScheme.onPrimary,
      body: const Center(
        child: Text("Favorite page"),
      ),
    );
  }
}