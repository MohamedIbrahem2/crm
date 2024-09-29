import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:get_ip_address/get_ip_address.dart';
import 'package:meta/meta.dart';
import 'package:crm/features/auth/domain/use_cases/login_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain/entities/response_login_entity.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
   bool isRememberMeChecked = false;
  LoginCubit(this._loginUesCase) : super(LoginInitial());
  final LoginUesCase _loginUesCase;
  void toggleRememberMe(bool value) async{
    isRememberMeChecked = value;
    emit(RememberMeToggled(isRememberMeChecked));
  }
  Future<void> login(String email, String password,bool isRememberMeChecked) async {

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    var ipAddress = IpAddress(type: RequestType.text);
    dynamic data = await ipAddress.getIpAddress();

    try {
      emit(LoginLoading());

      // Call the login use case with parameters
      Either<Failure, ResponseLoginEntity> result = await _loginUesCase(
        LoginParameters(email: email, password: password, device: androidInfo.brand, ipAddress: data),
      );

      result.fold(
            (failure) {
          // Handle failure case, emit error state
          emit(LoginError(failure.message!));
        },
            (responseLoginEntity) async {
          final token = responseLoginEntity.token;
          final moduleId = responseLoginEntity.moduleId;
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('moduleId', moduleId);
          if (kDebugMode) {
            print(token);
          }
          if (isRememberMeChecked) {
            await prefs.setString('token', token);
          }
          emit(LoginSuccess(token));
        },
      );
    } catch (error) {
      emit(LoginError(error.toString()));
    }
  }
  // Automatically log in if token exists
  Future<void> checkIfLoggedIn() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token != null) {
        print(token);
        print("====================");
        emit(LoginSuccess(token));
      } else {
        print("no token");
        emit(LoginInitial());
      }
    } catch (e) {
      print('Error in checkIfLoggedIn: $e');
      emit(LoginError('An error occurred.'));
    }
  }

  // Logout and clear the token from shared preferences
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    emit(LoggedOut());
  }
}
