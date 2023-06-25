import 'package:clean_architecture/core/error/exceptions.dart';
import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/core/network/network_info.dart';
import 'package:clean_architecture/features/random_quote/data/datasources/random_quote_local_data.dart';
import 'package:clean_architecture/features/random_quote/data/datasources/random_quote_remote_data.dart';
import 'package:clean_architecture/features/random_quote/domain/entities/quote.dart';
import 'package:clean_architecture/features/random_quote/domain/repositories/base_quote_repository.dart';
import 'package:dartz/dartz.dart';

class QuoteRepository implements BaseQuoteRepository {
  QuoteRepository(
      {required this.networkInfo,
      required this.randomQuoteRemoteData,
      required this.randomQuoteLocalData});
  NetworkInfo networkInfo;
  RandomQuoteRemoteData randomQuoteRemoteData;
  RandomQuoteLocalData randomQuoteLocalData;
  @override
  Future<Either<Failure, Quote>> getRandomQuote() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRandomQuote = await randomQuoteRemoteData.getRandomQuote();
        randomQuoteLocalData.cacheQuote(remoteRandomQuote);
        return Right(remoteRandomQuote);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localRandomQuote =
            await randomQuoteLocalData.getLastRqndomQuote();
        return Right(localRandomQuote);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
