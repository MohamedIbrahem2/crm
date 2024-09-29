import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/reminder_add_model.dart';
import '../../data/repositories/add_reminder_repository.dart';
part 'add_remienders_state.dart';
class AddRemindersCubit extends Cubit<AddRemindersState> {
  final AddReminderRepository reminderRepository;

  AddRemindersCubit(this.reminderRepository) : super(AddRemindersInitial());

  Future<void> addReminder(ReminderAddModel reminder,String leadId) async {
    try {
      emit(AddRemindersLoading());
      await reminderRepository.addReminder(reminder,leadId);
      emit(AddReminderAdded());
    } catch (e) {
      emit(AddRemindersError('Failed to add reminder'));
    }
  }

}

