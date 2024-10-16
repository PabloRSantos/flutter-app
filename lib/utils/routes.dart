import 'package:cointacao/screens/coin_detail_screen.dart';
import 'package:cointacao/screens/login_screen.dart';
import 'package:cointacao/screens/signup_screen.dart';
import 'package:cointacao/widgets/tabbar_widget.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String main = '/';
  static const String detail = '/detail';
  static const String login = '/login';
  static const String signup = '/signup';

  static Map<String, WidgetBuilder> routes() {
    return {
      main: (context) => const TabBarWidget(),
    };
  }

  // Método para navegação com argumentos
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case main:
        return MaterialPageRoute(
          builder: (context) => const TabBarWidget(),
        );

      case detail:
        final arguments = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (context) => CoinDetailScreen(
            code: arguments?['code'] ?? '',
          ),
        );

      case login:
        return MaterialPageRoute(
          builder: (context) => LoginScreen(),
        );

      case signup:
        return MaterialPageRoute(
          builder: (context) => SignUpScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const TabBarWidget(),
        );
    }
  }
}
