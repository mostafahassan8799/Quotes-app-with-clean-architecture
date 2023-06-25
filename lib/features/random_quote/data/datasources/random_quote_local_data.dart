// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:clean_architecture/core/error/exceptions.dart';
import 'package:clean_architecture/core/utils/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:clean_architecture/features/random_quote/data/models/quote_model.dart';

abstract class RandomQuoteLocalData {
  Future<QuoteModel> getLastRqndomQuote();
  Future<void> cacheQuote(QuoteModel quoteModel);
}

class RandomQuoteLocalDataImpl implements RandomQuoteLocalData {
  final SharedPreferences sharedPreferences;
  RandomQuoteLocalDataImpl({
    required this.sharedPreferences,
  });
  @override
  Future<QuoteModel> getLastRqndomQuote() {
    final jsonString = sharedPreferences.getString(AppStrings.cacheRandomQuote);
    if (jsonString != null) {
      final cachedRandomQuote =
          Future.value(QuoteModel.fromJson(json.decode(jsonString)));
      return cachedRandomQuote;
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheQuote(QuoteModel quoteModel) {
    return sharedPreferences.setString(
        AppStrings.cacheRandomQuote, json.encode(quoteModel));
  }
}
