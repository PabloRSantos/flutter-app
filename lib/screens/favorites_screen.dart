import 'package:cointacao/stores/coin_store.dart';
import 'package:cointacao/stores/user_store.dart';
import 'package:cointacao/widgets/appbar_widget.dart';
import 'package:cointacao/widgets/card_widget.dart';
import 'package:cointacao/widgets/searchbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late CoinStore coinStore;
  late UserStore userStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userStore = Provider.of<UserStore>(context, listen: false);
    coinStore = Provider.of<CoinStore>(context, listen: false);
    coinStore.listCoins(favorite: true, codes: userStore.user?.coins);
  }

  Future<void> _refreshCoins() async {
    await coinStore.listCoins(favorite: true, codes: userStore.user?.coins);
  }

  void onSearch(String term) {
    coinStore.listCoins(
        term: term, favorite: true, codes: userStore.user?.coins);
  }

  @override
  Widget build(BuildContext context) {
    final coinStore = Provider.of<CoinStore>(context);
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: const AppBarWidget(
        title: "Favoritos",
      ),
      backgroundColor: colorScheme.onPrimary,
      body: Column(
        children: [
          SearchBarWidget(
            onSearch: onSearch,
          ),
          Expanded(
            child: AnimatedBuilder(
              animation:
                  Listenable.merge([coinStore.isLoading, coinStore.state]),
              builder: (context, child) {
                if (coinStore.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                return RefreshIndicator(
                  onRefresh: _refreshCoins,
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    itemCount: coinStore.state.value.length,
                    itemBuilder: (_, index) {
                      final coin = coinStore.state.value[index];
                      return CardWidget(
                        pressable: true,
                        code: coin.code,
                        name: coin.name,
                        value: coin.value,
                        varBid: coin.varBid,
                        pctChange: coin.pctChange,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
