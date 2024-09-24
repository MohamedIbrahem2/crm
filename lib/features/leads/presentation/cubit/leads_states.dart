import '../../data/models/leads_model.dart';

abstract class LeadsState {}

class LeadsInitial extends LeadsState {}

class LeadsLoading extends LeadsState {}

class LeadsLoaded extends LeadsState {
  final List<Lead> leads;

  LeadsLoaded(this.leads);
}

class LeadsError extends LeadsState {
  final String message;

  LeadsError(this.message);
}
