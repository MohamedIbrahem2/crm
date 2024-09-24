
import 'package:equatable/equatable.dart';

abstract class AddLeadState extends Equatable {
  const AddLeadState();

  @override
  List<Object> get props => [];
}

class AddLeadInitial extends AddLeadState {}

class AddLeadLoading extends AddLeadState {}

class AddLeadSuccess extends AddLeadState {
  final dynamic response;

  const AddLeadSuccess(this.response);

  @override
  List<Object> get props => [response];
}

class AddLeadError extends AddLeadState {
  final String error;

  const AddLeadError(this.error);

  @override
  List<Object> get props => [error];
}
