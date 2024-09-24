
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/leads_repository.dart';
import 'leads_states.dart';
class LeadsCubit extends Cubit<LeadsState> {
  final LeadsRepository leadsRepository;

  LeadsCubit(this.leadsRepository) : super(LeadsInitial());

  Future<void> fetchLeads() async {
    try {
      emit(LeadsLoading());

      final leads = await leadsRepository.getLeads();
      if (leads.isNotEmpty) {
        if (!isClosed) {  // Check if cubit is closed before emitting state
          emit(LeadsLoaded(leads));
        }
      }
    } catch (e) {
      if (!isClosed) {
        emit(LeadsError(e.toString()));
      }
    }
  }
}
