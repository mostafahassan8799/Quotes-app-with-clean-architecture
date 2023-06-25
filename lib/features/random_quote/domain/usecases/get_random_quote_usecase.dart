// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_architecture/features/random_quote/domain/repositories/base_quote_repository.dart';
import 'package:dartz/dartz.dart';

import 'package:clean_architecture/core/base_usecase/base_usecase.dart';
import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/random_quote/domain/entities/quote.dart';

class GetRandomQuoteUsecase implements BaseUsecase<Quote, NoParams> {
  final BaseQuoteRepository baseQuoteRepository;
  GetRandomQuoteUsecase({
    required this.baseQuoteRepository,
  });
  @override
  Future<Either<Failure, Quote>> call(NoParams noParams) {
    return baseQuoteRepository.getRandomQuote();
  }
}
