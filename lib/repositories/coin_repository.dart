import 'dart:convert';

import 'package:cointacao/models/coin_detail_model.dart';
import 'package:cointacao/models/coin_model.dart';
import 'package:cointacao/services/http_service.dart';

class CoinRepository {
  final HttpService httpService;
  final String allCoins =
      'USD-BRL,CAD-BRL,EUR-BRL,GBP-BRL,ARS-BRL,BTC-BRL,LTC-BRL,JPY-BRL,CHF-BRL,AUD-BRL,CNY-BRL,ILS-BRL,ETH-BRL,XRP-BRL,DOGE-BRL,SGD-BRL,AED-BRL,DKK-BRL,HKD-BRL,MXN-BRL,NOK-BRL,NZD-BRL,PLN-BRL,SAR-BRL,SEK-BRL,THB-BRL,TRY-BRL,TWD-BRL,VEF-BRL,ZAR-BRL,CLP-BRL,PYG-BRL,UYU-BRL,COP-BRL,PEN-BRL,BOB-BRL,RUB-BRL,INR-BRL';

  CoinRepository({required this.httpService});

  Future<CoinDetailModel> getCoinDetails(String code) async {
    final response = await httpService.get(url: '/daily/$code-BRL/30');
    final body = jsonDecode(response.body);

    final coin = CoinDetailModel.fromMap(
        {'name': body[0]['name'], 'code': code, 'statements': body});

    return coin;
  }

  Future<List<CoinModel>> listCoins(List<String>? codes) async {
    final isDefined = codes != null && codes.isNotEmpty;
    final params = isDefined ? codes.join(",") : allCoins;

    final response = await httpService.get(url: '/last/$params');
    final body = jsonDecode(response.body);

    final List<CoinModel> coins = [];
    body.values.toList().forEach((item) {
      final CoinModel coin = CoinModel.fromMap(item);
      coins.add(coin);
    });

    return coins;
  }
}
