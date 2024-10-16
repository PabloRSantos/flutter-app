import 'package:cointacao/repositories/auth_repository.dart';
import 'package:cointacao/repositories/coin_repository.dart';
import 'package:cointacao/repositories/user_repository.dart';
import 'package:cointacao/services/auth_service.dart';
import 'package:cointacao/services/http_service.dart';
import 'package:cointacao/stores/coin_detail_store.dart';
import 'package:cointacao/stores/coin_store.dart';
import 'package:cointacao/stores/user_store.dart';

class StoreFactory {
  static final StoreFactory _instance = StoreFactory._internal();

  factory StoreFactory() {
    return _instance;
  }

  StoreFactory._internal();

  final UserRepository _userRepository = UserRepository();
  final AuthRepository _authRepository = AuthRepository(AuthService());
  final CoinRepository _coinRepository = CoinRepository(
    httpService: HttpService(),
  );

  UserStore? _userStore;
  CoinStore? _coinStore;
  CoinDetailStore? _coinDetailStore;

  UserStore getUserStore() {
    _userStore ??= UserStore(
        userRepository: _userRepository, authRepository: _authRepository);
    return _userStore!;
  }

  CoinStore getCoinStore() {
    _coinStore ??= CoinStore(
        coinRepository: _coinRepository, userRepository: _userRepository);
    return _coinStore!;
  }

  CoinDetailStore getCoinDetailStore() {
    _coinDetailStore ??= CoinDetailStore(
        coinRepository: _coinRepository, userRepository: _userRepository);
    return _coinDetailStore!;
  }
}
