import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../features/auth/data/data_sources/login_remote_data_source.dart';
import '../../features/auth/data/repositories/login_repository_impl.dart';
import '../../features/auth/domain/repositories/login_repository.dart';
import '../../features/auth/domain/use_cases/login_usecase.dart';
import '../../features/auth/presentation/cubit/login_cubit/login_cubit.dart';
import '../networking/dio_factory.dart';

final sl = GetIt.instance;

class ServicesLocator {
  Future<void> init() async {
    ///Dio
    Dio dio = DioFactory.getDio();

    ///Cubit
    //Auth Cubits
    sl.registerFactory<LoginCubit>(
        () => LoginCubit(sl()));
    // sl.registerFactory<FetchGoldPriceCubit>(() => FetchGoldPriceCubit(sl()));

    //-------------------------------------------------------------------------------------------------//
    ///UseCase
    //Auth Cases
    sl.registerLazySingleton<LoginUesCase>(
        () => LoginUesCase(sl.call()));


    //-------------------------------------------------------------------------------------------------//
    ///Repository
    //Auth Repository
    sl.registerLazySingleton<LoginRepository>(
        () => LoginRepositoryImpl(sl()));

    //-------------------------------------------------------------------------------------------------//
    ///DataSource
    //home DataSource
    sl.registerLazySingleton<LoginRemoteDataSource>(
        () => LoginRemoteDataSource(dio));

  }
}
