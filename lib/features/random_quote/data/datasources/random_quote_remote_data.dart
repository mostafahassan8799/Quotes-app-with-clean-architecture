// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:clean_architecture/core/api/end_points.dart';
import 'package:clean_architecture/core/error/exceptions.dart';
import 'package:clean_architecture/core/utils/app_strings.dart';
import 'package:http/http.dart' as http;

import 'package:clean_architecture/features/random_quote/data/models/quote_model.dart';

abstract class RandomQuoteRemoteData {
  Future<QuoteModel> getRandomQuote();
}

class RandomQuoteRemoteDataImpl implements RandomQuoteRemoteData {
  http.Client client;
  RandomQuoteRemoteDataImpl({
    required this.client,
  });

  @override
  Future<QuoteModel> getRandomQuote() async {
    final randomQuoteUrl = Uri.parse(EndPoints.randomQuote);
    final response = await client.get(randomQuoteUrl,
        headers: {AppStrings.contentType: AppStrings.applicationJson});
    if (response.statusCode == 200) {
      return QuoteModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
