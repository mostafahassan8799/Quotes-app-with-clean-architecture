import 'package:clean_architecture/features/favourite_quote/presentation/screens/favourite_quote_screen.dart';
import 'package:clean_architecture/features/random_quote/presentation/cubit/random_quote_cubit.dart';
import 'package:clean_architecture/features/random_quote/presentation/screens/quote_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_architecture/injection_container.dart' as di;

class Routes {
  static const String initialRoute = '/';
  static const String favouriteQuoteRoute = '/favouriteQuote';
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
            builder: (context) => BlocProvider(
                  create: ((context) => di.sl<RandomQuoteCubit>()),
                  child: const QuoteScreen(),
                ));
      case Routes.favouriteQuoteRoute:
        return MaterialPageRoute(
            builder: (context) => const FavouriteQuoteScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: ((context) => const Scaffold(
              body: Center(
                child: Text('not found'),
              ),
            )));
  }
}
