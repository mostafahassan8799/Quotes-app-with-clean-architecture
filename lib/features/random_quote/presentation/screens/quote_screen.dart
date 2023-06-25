import 'package:clean_architecture/core/utils/app_colors.dart';
import 'package:clean_architecture/core/utils/app_strings.dart';
import 'package:clean_architecture/features/random_quote/presentation/widgets/quote_content.dart';
import 'package:flutter/material.dart';

class QuoteScreen extends StatelessWidget {
  const QuoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppBar appBar = buildAppBar();
    return Scaffold(
      body: _buildBodyContent(),
      appBar: appBar,
    );
  }

  AppBar buildAppBar() {
    final appBar = AppBar(
      title: const Text(AppStrings.appName),
    );
    return appBar;
  }
}

Widget _buildBodyContent() {
  return Column(
    children: [
      const QuoteContent(),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: AppColors.primaryColor),
        child: const Icon(
          Icons.refresh,
          size: 32,
          color: Colors.white,
        ),
      ),
    ],
  );
}
