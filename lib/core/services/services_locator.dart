import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../networking/dio_factory.dart';

final sl = GetIt.instance;

class ServicesLocator {
  Future<void> init() async {
    ///Dio
    Dio dio = DioFactory.getDio();

    ///Cubit
    //home Cubits
    // sl.registerFactory<FetchCurrencyDataCubit>(
    //     () => FetchCurrencyDataCubit(sl()));
    // sl.registerFactory<FetchGoldPriceCubit>(() => FetchGoldPriceCubit(sl()));

    //-------------------------------------------------------------------------------------------------//
    ///UseCase
    //home Cases
    // sl.registerLazySingleton<FetchCurrencyDataUseCase>(
    //     () => FetchCurrencyDataUseCase(sl.call()));
    // sl.registerLazySingleton<FetchGoldPriceUseCase>(
    //     () => FetchGoldPriceUseCase(sl.call()));

    //-------------------------------------------------------------------------------------------------//
    ///Repository
    //Auth Repository
    // sl.registerLazySingleton<HomeRepository>(
    //     () => HomeRepositoryImpl(sl(), sl()));

    //-------------------------------------------------------------------------------------------------//
    ///DataSource
    //home DataSource
    // sl.registerLazySingleton<HomeRemoteDataSourceCurrencyDataSource>(
    //     () => HomeRemoteDataSourceCurrencyDataSource(dio));
    // sl.registerLazySingleton<HomeRemoteDataGoldPriceDataSource>(
    //     () => HomeRemoteDataGoldPriceDataSource(dio));
  }
}
