import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sales_crm/features/auth/domain/use_cases/login_usecase.dart';

import '../../../domain/entities/response_login_entity.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._loginUesCase) : super(LoginInitial());
  final LoginUesCase _loginUesCase;

  Future<void> login(String email, String password, String device, String location) async {
    emit(LoginLoading());
    final result = await _loginUesCase(LoginParameters(email: email, password: password, device: device, location: location));
    result.fold(
      (failure) => emit(LoginError(failure.message ?? 'An error occurred')),
      (response) => emit(LoginSuccess(response)),
    );
  }
}
