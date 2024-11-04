import 'package:cointacao/factories/store_factory.dart';
import 'package:cointacao/stores/coin_detail_store.dart';
import 'package:cointacao/stores/coin_store.dart';
import 'package:cointacao/stores/user_store.dart';
import 'package:cointacao/utils/routes.dart';
import 'package:cointacao/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final userStore = StoreFactory().getUserStore();
  await userStore.fetchUser();

  runApp(MyApp(userStore: userStore));
}

class MyApp extends StatelessWidget {
  final UserStore userStore;

  const MyApp({super.key, required this.userStore});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<UserStore>.value(value: userStore),
        Provider<CoinStore>(create: (_) => StoreFactory().getCoinStore()),
        Provider<CoinDetailStore>(
            create: (_) => StoreFactory().getCoinDetailStore()),
      ],
      child: MaterialApp(
        title: 'Cointação',
        theme: AppTheme.lightTheme(),
        initialRoute: userStore.user == null ? AppRoutes.login : AppRoutes.main,
        routes: AppRoutes.routes(),
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
