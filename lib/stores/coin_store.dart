import 'package:cointacao/models/coin_model.dart';
import 'package:cointacao/repositories/coin_repository.dart';
import 'package:cointacao/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:diacritic/diacritic.dart';

class CoinStore {
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<List<CoinModel>> state =
      ValueNotifier<List<CoinModel>>([]);

  final CoinRepository coinRepository;
  final UserRepository userRepository;

  CoinStore({required this.coinRepository, required this.userRepository});

  listCoins({String? term, List<String>? codes, bool? favorite}) async {
    final noFavoriteCode = codes == null || codes.isEmpty;
    if (favorite == true && noFavoriteCode) {
      Future.microtask(() => state.value = []);
      return;
    }

    Future.microtask(() => isLoading.value = true);

    final coins = await coinRepository.listCoins(codes);

    if (term != null) {
      final RegExp regex = RegExp(
        term,
        caseSensitive: false,
      );

      Future.microtask(() {
        state.value = coins
            .where((item) =>
                regex.hasMatch(removeDiacritics(item.name)) ||
                regex.hasMatch(item.code))
            .toList();
      });
    } else {
      Future.microtask(() => state.value = coins);
    }

    Future.microtask(() => isLoading.value = false);
  }
}
