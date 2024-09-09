import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/response_login_entity.dart';
import '../use_cases/login_usecase.dart';


abstract class LoginRepository {
  Future<Either<Failure, ResponseLoginEntity>> login(LoginParameters parameters);
}
