import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final String type;
  final VoidCallback onPressed;

  const CustomButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.type});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      height: 58,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
          backgroundColor:
              type == 'primary' ? colorScheme.primary : colorScheme.onPrimary,
          side: BorderSide(color: colorScheme.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(text,
            style: TextStyle(
                fontSize: 18,
                color: type == 'primary'
                    ? colorScheme.onPrimary
                    : colorScheme.primary)),
      ),
    );
  }
}
