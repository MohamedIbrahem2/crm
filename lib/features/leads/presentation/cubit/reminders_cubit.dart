import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/leads_model.dart';
import '../../data/models/remienders_model.dart';
import '../../data/repositories/remienders_repository.dart';


part 'reminders_state.dart';

class RemindersCubit extends Cubit<RemindersState> {
  final ReminderRepository reminderRepository;

  RemindersCubit(this.reminderRepository) : super(RemindersInitial());

  Future<void> fetchReminders(String leadId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      emit(RemindersLoading());
      final reminders = await reminderRepository.getReminders(token!,leadId);
      emit(RemindersLoaded(reminders));
    } catch (e) {
      emit(RemindersError(e.toString()));
    }
  }
}
