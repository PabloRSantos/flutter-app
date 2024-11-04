import 'package:cointacao/utils/format.dart';
import 'package:cointacao/utils/routes.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String code;
  final String name;
  final double value;
  final double varBid;
  final String pctChange;
  final bool pressable;

  const CardWidget(
      {super.key,
      required this.code,
      required this.name,
      required this.value,
      required this.varBid,
      required this.pctChange,
      required this.pressable});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var colorScheme = theme.colorScheme;

    Color varianceColor = varBid > 0 ? colorScheme.primary : colorScheme.error;

    return Center(
        child: FractionallySizedBox(
      widthFactor: 0.95,
      child: Card(
        elevation: 3,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          splashColor: theme.primaryColor.withAlpha(30),
          onTap: () {
            if (!pressable) return;

            Navigator.pushNamed(context, AppRoutes.detail,
                arguments: {'code': code});
          },
          child: SizedBox(
            height: 75,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: theme.textTheme.labelMedium),
                      Text(code, style: theme.textTheme.labelSmall)
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(Formatter.currency(value),
                          style: theme.textTheme.labelLarge),
                      Text(
                        '${Formatter.currency(varBid)} ($pctChange%)',
                        style: TextStyle(fontSize: 11.0, color: varianceColor),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
