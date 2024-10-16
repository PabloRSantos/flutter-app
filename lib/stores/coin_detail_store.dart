import 'package:cointacao/models/coin_detail_model.dart';
import 'package:cointacao/repositories/coin_repository.dart';
import 'package:cointacao/repositories/user_repository.dart';
import 'package:flutter/material.dart';

class CoinDetailStore {
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<CoinDetailModel?> state =
      ValueNotifier<CoinDetailModel?>(null);

  final CoinRepository coinRepository;
  final UserRepository userRepository;

  CoinDetailStore({required this.coinRepository, required this.userRepository});

  getCoin({required String code}) async {
    isLoading.value = true;

    final coin = await coinRepository.getCoinDetails(code);
    state.value = coin;

    isLoading.value = false;
  }

  Future<void> favorite(String coinCode, String? userId) async {
    if (userId == null) {
      throw Error();
    }

    var user = await userRepository.getUser(userId);

    if (user == null) {
      throw Error();
    }

    user.pushCoin(coinCode);
    await userRepository.update(user);
  }
}
