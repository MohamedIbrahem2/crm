part of 'reminders_cubit.dart';

@immutable
abstract class RemindersState {}

class RemindersInitial extends RemindersState {}

class RemindersLoading extends RemindersState {}

class RemindersLoaded extends RemindersState {
  final List<ReminderModel> reminders;
  RemindersLoaded(this.reminders);
}

class RemindersError extends RemindersState {
  final String message;
  RemindersError(this.message);
}
