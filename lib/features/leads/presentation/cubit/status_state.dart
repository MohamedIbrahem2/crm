import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/repositories/status_repository.dart';

// Define your states
class StatusState extends Equatable {
  @override
  List<Object> get props => [];
}

class StatusInitial extends StatusState {}

class StatusLoading extends StatusState {}

class StatusLoaded extends StatusState {
  final Map<String, int> statusCounts;

  StatusLoaded(this.statusCounts);

  @override
  List<Object> get props => [statusCounts];
}

class StatusError extends StatusState {
  final String message;

  StatusError(this.message);

  @override
  List<Object> get props => [message];
}

// Cubit Class

