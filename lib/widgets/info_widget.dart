import 'package:flutter/material.dart';

class InfoWidget extends StatelessWidget {
  final String label;
  final String? value;

  const InfoWidget({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: theme.textTheme.labelMedium),
          Text(value ?? '', style: theme.textTheme.labelSmall),
          const SizedBox(
            height: 32.0,
          )
        ],
      ),
    );
  }
}
