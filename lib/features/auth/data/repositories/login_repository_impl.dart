import 'package:dartz/dartz.dart';
import 'package:sales_crm/features/auth/domain/use_cases/login_usecase.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/response_login_entity.dart';
import '../../domain/repositories/login_repository.dart';
import '../data_sources/login_remote_data_source.dart';

class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl(this._loginRemoteDataSource);

  final LoginRemoteDataSource _loginRemoteDataSource;

  @override
  Future<Either<Failure, ResponseLoginEntity>> login(LoginParameters parameters) async {
    try {
      final result = await _loginRemoteDataSource.login(parameters);
      return Right(result);
    } catch (e) {
      print('Error occurred: $e');
      return Left(ServerFailure.handle(e));
    }
  }
  }






