part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final dynamic data; // Replace with your actual data type
  ProfileLoaded(this.data);
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}

class ProfileSuccess extends ProfileState {
  final String message;
  ProfileSuccess(this.message);
}
