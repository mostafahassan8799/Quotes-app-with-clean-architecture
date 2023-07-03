import 'package:bloc/bloc.dart';
import 'package:clean_architecture/core/base_usecase/base_usecase.dart';
import 'package:clean_architecture/core/error/failure.dart';
import 'package:clean_architecture/core/utils/app_strings.dart';
import 'package:clean_architecture/features/random_quote/domain/entities/quote.dart';
import 'package:clean_architecture/features/random_quote/domain/usecases/get_random_quote_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'random_quote_state.dart';

class RandomQuoteCubit extends Cubit<RandomQuoteState> {
  final GetRandomQuoteUsecase getRandomQuoteUsecase;
  RandomQuoteCubit({required this.getRandomQuoteUsecase})
      : super(RandomQuoteInitial());
  Future<void> getRandomQuote() async {
    emit(RandomQuoteIsLoading());
    Either<Failure, Quote> response = await getRandomQuoteUsecase(NoParams());
    emit(response.fold(
        (failure) => RandomQuoteFailure(message: _mapFailureToMsg(failure)),
        (quote) => RandomQuotSuccess(quote: quote)));
  }
}

String _mapFailureToMsg(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return AppStrings.serverFailure;
    case CacheFailure:
      return AppStrings.cacheFailure;
    default:
      return AppStrings.unExpectedError;
  }
}
