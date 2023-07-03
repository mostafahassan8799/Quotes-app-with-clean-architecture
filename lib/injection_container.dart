import 'package:clean_architecture/core/network/network_info.dart';
import 'package:clean_architecture/features/random_quote/data/datasources/random_quote_local_data.dart';
import 'package:clean_architecture/features/random_quote/data/datasources/random_quote_remote_data.dart';
import 'package:clean_architecture/features/random_quote/data/repositories/quote_repository.dart';
import 'package:clean_architecture/features/random_quote/domain/repositories/base_quote_repository.dart';
import 'package:clean_architecture/features/random_quote/domain/usecases/get_random_quote_usecase.dart';
import 'package:clean_architecture/features/random_quote/presentation/cubit/random_quote_cubit.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features

  // Blocs
  sl.registerFactory<RandomQuoteCubit>(
      () => RandomQuoteCubit(getRandomQuoteUsecase: sl()));

  // Use cases
  sl.registerLazySingleton<GetRandomQuoteUsecase>(
      () => GetRandomQuoteUsecase(baseQuoteRepository: sl()));

  // Repository
  sl.registerLazySingleton<BaseQuoteRepository>(() => QuoteRepository(
        networkInfo: sl(),
        randomQuoteLocalData: sl(),
        randomQuoteRemoteData: sl(),
      ));

  // Data Sources
  sl.registerLazySingleton<RandomQuoteLocalData>(
      () => RandomQuoteLocalDataImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<RandomQuoteRemoteData>(
      () => RandomQuoteRemoteDataImpl(client: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(internetConnection: sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnection());
}
