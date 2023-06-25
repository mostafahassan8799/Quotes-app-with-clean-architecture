import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/features/random_quote/domain/entities/quote.dart';
import 'package:dartz/dartz.dart';

abstract class BaseQuoteRepository {
  Future<Either<Failure, Quote>> getRandomQuote();
}
