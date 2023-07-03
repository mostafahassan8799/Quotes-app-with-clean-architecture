import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clean_architecture/core/utils/app_colors.dart';
import 'package:clean_architecture/core/utils/app_strings.dart';
import 'package:clean_architecture/features/random_quote/presentation/cubit/random_quote_cubit.dart';
import 'package:clean_architecture/features/random_quote/presentation/widgets/quote_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_architecture/core/widget/error_widget.dart'
    as error_widget;

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  _getRandomQuote() =>
      BlocProvider.of<RandomQuoteCubit>(context).getRandomQuote();
  @override
  void initState() {
    super.initState();
    _getRandomQuote();
  }

  Widget _buildBodyContent() {
    return BlocBuilder<RandomQuoteCubit, RandomQuoteState>(
        builder: ((context, state) {
      if (state is RandomQuoteIsLoading) {
        return Center(
            child: SpinKitFadingCircle(
          color: AppColors.primaryColor,
        ));
      } else if (state is RandomQuotSuccess) {
        return Column(
          children: [
            QuoteContent(
              quote: state.quote,
            ),
            InkWell(
              onTap: _getRandomQuote(),
              child: Container(
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
            ),
          ],
        );
      } else if (state is RandomQuoteFailure) {
        return const Center(
          child: error_widget.ErrorWidget(),
        );
      } else {
        return Center(
            child: SpinKitFadingCircle(
          color: AppColors.primaryColor,
        ));
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = buildAppBar();
    return RefreshIndicator(
        child: Scaffold(appBar: appBar, body: _buildBodyContent()),
        onRefresh: () => _getRandomQuote());
  }

  AppBar buildAppBar() {
    final appBar = AppBar(
      title: const Text(AppStrings.appName),
    );
    return appBar;
  }
}
