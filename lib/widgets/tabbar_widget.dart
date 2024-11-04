import 'package:cointacao/screens/coins_screen.dart';
import 'package:cointacao/screens/favorites_screen.dart';
import 'package:cointacao/screens/profile.dart';
import 'package:flutter/material.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      // initialIndex: 2,
      child: Scaffold(
        body: TabBarView(
          children: [
            const FavoriteScreen(),
            const CoinsScreen(),
            Profile(),
          ],
        ),
        bottomNavigationBar: Container(
          color: colorScheme.onPrimary,
          child: TabBar(
            indicatorColor: colorScheme.primary,
            unselectedLabelColor: colorScheme.primary.withOpacity(0.5),
            tabs: const [
              Tab(icon: Icon(Icons.favorite_border)),
              Tab(icon: Icon(Icons.currency_exchange)),
              Tab(icon: Icon(Icons.person)),
            ],
          ),
        ),
      ),
    );
  }
}
