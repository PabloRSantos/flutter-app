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

  listCoins({String? term}) async {
    isLoading.value = true;

    final coins = await coinRepository.listCoins();

    if (term != null) {
      final RegExp regex = RegExp(
        term,
        caseSensitive: false,
      );

      state.value = coins
          .where((item) =>
              regex.hasMatch(removeDiacritics(item.name)) ||
              regex.hasMatch(item.code))
          .toList();
    } else {
      state.value = coins;
    }

    isLoading.value = false;
  }
}
