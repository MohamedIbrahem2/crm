part of 'login_cubit.dart';

@immutable
abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final ResponseLoginEntity response;

  LoginSuccess(this.response);
}

class LoginError extends LoginState {
  final String message;

  LoginError(this.message);
}
