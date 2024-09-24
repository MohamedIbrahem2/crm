abstract class StatusState {}

class StatusInitial extends StatusState {}

class StatusLoading extends StatusState {}

class StatusLoaded extends StatusState {
  final List<String> statusNames; // Change to List<String>

  StatusLoaded(this.statusNames);
}

class StatusError extends StatusState {
  final String message;

  StatusError(this.message);
}
