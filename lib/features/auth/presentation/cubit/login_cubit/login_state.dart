part of 'login_cubit.dart';

@immutable
abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  // final ResponseLoginEntity response;
  final String token;
  LoginSuccess( this.token);
  @override
  List<Object> get props => [token];
}

class LoginError extends LoginState {
  final String message;

  LoginError(this.message);
}
class RememberMeToggled extends LoginState {
  final bool isRememberMeChecked;
  RememberMeToggled(this.isRememberMeChecked);
}

class LoggedOut extends LoginState {}