import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBarWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return AppBar(
       title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                  color: colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 26.0),
            ),
          ),
          centerTitle: true,
          backgroundColor: colorScheme.primary,
          toolbarHeight: 125.0,
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight) * 2;
}