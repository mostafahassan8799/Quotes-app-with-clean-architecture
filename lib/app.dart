import 'package:clean_architecture/config/routes/app_routes.dart';
import 'package:clean_architecture/config/themes/app_theme.dart';
import 'package:clean_architecture/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

import 'features/random_quote/presentation/screens/quote_screen.dart';

class QuoteApp extends StatelessWidget {
  const QuoteApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      theme: appTheme(),
      home: const QuoteScreen(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}
