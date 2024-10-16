import 'package:cointacao/stores/coin_detail_store.dart';
import 'package:cointacao/stores/user_store.dart';
import 'package:cointacao/widgets/appbar_widget.dart';
import 'package:cointacao/widgets/button_widget.dart';
import 'package:cointacao/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoinDetailScreen extends StatefulWidget {
  final String code;
  const CoinDetailScreen({super.key, required this.code});

  @override
  State<CoinDetailScreen> createState() => _CoinDetailScreenState();
}

class _CoinDetailScreenState extends State<CoinDetailScreen> {
  late CoinDetailStore coinDetailStore;
  late UserStore userStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    userStore = Provider.of<UserStore>(context, listen: false);
    coinDetailStore = Provider.of<CoinDetailStore>(context, listen: false);
    coinDetailStore.getCoin(code: widget.code);
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return AnimatedBuilder(
      animation:
          Listenable.merge([coinDetailStore.isLoading, coinDetailStore.state]),
      builder: (context, child) {
        if (coinDetailStore.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final coin = coinDetailStore.state.value!;
        return Scaffold(
          appBar: AppBarWidget(
            title: coinDetailStore.state.value!.name,
          ),
          backgroundColor: colorScheme.onPrimary,
          body: Column(
            children: [
              CardWidget(
                code: coin.code,
                name: coin.name,
                value: coin.statements[0].value,
                varBid: coin.statements[0].varBid,
                pctChange: coin.statements[0].pctChange,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: CustomButton(
                    text: "Favoritar",
                    onPressed: () {
                      coinDetailStore.favorite(widget.code, userStore.user?.id);
                    },
                    type: 'primary'),
              )
            ],
          ),
        );
      },
    );
  }
}
