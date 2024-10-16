import 'package:cointacao/stores/coin_store.dart';
import 'package:cointacao/widgets/appbar_widget.dart';
import 'package:cointacao/widgets/card_widget.dart';
import 'package:cointacao/widgets/searchbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoinsScreen extends StatefulWidget {
  const CoinsScreen({super.key});

  @override
  State<CoinsScreen> createState() => _CoinsScreenState();
}

class _CoinsScreenState extends State<CoinsScreen> {
  late CoinStore store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    store = Provider.of<CoinStore>(context, listen: false);
    store.listCoins();
  }

  void onSearch(String term) {
    store.listCoins(term: term);
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<CoinStore>(context);
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: const AppBarWidget(
        title: "Moedas",
      ),
      backgroundColor: colorScheme.onPrimary,
      body: Column(
        children: [
          SearchBarWidget(
            onSearch: onSearch,
          ),
          Expanded(
            child: AnimatedBuilder(
              animation: Listenable.merge([store.isLoading, store.state]),
              builder: (context, child) {
                if (store.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemCount: store.state.value.length,
                  itemBuilder: (_, index) {
                    final coin = store.state.value[index];
                    return CardWidget(
                      code: coin.code,
                      name: coin.name,
                      value: coin.value,
                      varBid: coin.varBid,
                      pctChange: coin.pctChange,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
