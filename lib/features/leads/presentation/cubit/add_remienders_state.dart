part of 'add_remienders_cubit.dart';

@immutable
abstract class AddRemindersState {}

class AddRemindersInitial extends AddRemindersState {}

class AddRemindersLoading extends AddRemindersState {}
class AddReminderAdded extends AddRemindersState {}


class AddRemindersLoaded extends AddRemindersState {
  final List<ReminderAddModel> reminders;
  AddRemindersLoaded(this.reminders);
}

class AddRemindersError extends AddRemindersState {
  final String message;
  AddRemindersError(this.message);
  List<Object> get props => [message];
}
