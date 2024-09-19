import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sales_crm/features/auth/domain/repositories/login_repository.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usaecase/uasecase.dart';
import '../entities/response_login_entity.dart';

class LoginUesCase extends UseCase<ResponseLoginEntity, LoginParameters> {
  final LoginRepository _loginRepository;

  LoginUesCase(this._loginRepository);

  @override
  Future<Either<Failure, ResponseLoginEntity>> call(LoginParameters params) async {
    return await _loginRepository.login(params);
  }
}

class LoginParameters extends Equatable {
  final String email;
  final String password;
   final String? device;
   final String ipAddress;

  const LoginParameters({
    required this.email,
    required this.password,
     required this.device,
     required this.ipAddress,
  });

  @override
  List<Object?> get props => [
        email,
        password,
         device,
        ipAddress,
      ];
  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
    "device":device,
    "ip_address" : ipAddress,
  };
}
