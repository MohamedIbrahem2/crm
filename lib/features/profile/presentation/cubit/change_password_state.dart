part of 'change_password_cubit.dart';

// Define the base class for different password change states
abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordLoading extends ChangePasswordState {}

class ChangePasswordSuccess extends ChangePasswordState {
  final String message;

  const ChangePasswordSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class ChangePasswordFailure extends ChangePasswordState {
  final String error;

  const ChangePasswordFailure(this.error);

  @override
  List<Object> get props => [error];
}
