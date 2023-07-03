import 'package:clean_architecture/config/routes/app_routes.dart';
import 'package:clean_architecture/config/themes/app_theme.dart';
import 'package:clean_architecture/core/utils/app_strings.dart';
import 'package:clean_architecture/features/random_quote/presentation/cubit/random_quote_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;
import 'features/random_quote/presentation/screens/quote_screen.dart';

class QuoteApp extends StatelessWidget {
  const QuoteApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: ((context) => di.sl<RandomQuoteCubit>()),
      child: MaterialApp(
        title: AppStrings.appName,
        theme: appTheme(),
        home: const QuoteScreen(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
