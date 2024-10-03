import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crm/features/leads/presentation/cubit/add_leads_state.dart';

import '../../data/repositories/add_leads_repository.dart';

class AddLeadsCubit extends Cubit<AddLeadState> {
  final AddLeadsRepository _addLeadsRepository;

  AddLeadsCubit(this._addLeadsRepository) : super(AddLeadInitial());

  Future<void> addLead({
    required String name,
    required String phone,
    required String email,
    required String company,
    required String city,
    required String address,
    required int leadValue,
    required String position,
    required String state,
    required int countryId,
    required String website,
    required String zipCode,
    required int productType,
    required int sourceId,
    required int statusId,
    required int assignedTo,
    required int productRelatedId,
  }) async {
    print("Adding lead with name: $name");
    emit(AddLeadLoading());
    try {
      final response = await _addLeadsRepository.addLead(
        name: name,
        phone: phone,
        email: email,
        company: company,
        city: city,
        address: address,
        leadValue: leadValue,
        position: position,
        state: state,
        countryId: countryId,
        website: website,
        zipCode: zipCode,
        sourceId: sourceId,
        statusId: statusId,
        assignedTo: assignedTo,
        productRelatedId: productRelatedId,
        productType: productType,
      );
      if (response.isSuccess) {
        print("Lead added successfully");
        emit(AddLeadSuccess(response));
      } else {

        emit(AddLeadError(response.message ?? "Failed to add lead"));
      }
    } catch (e) {
      print("Error adding lead: $e");
      emit(AddLeadError("An error occurred: ${e.toString()}"));
    }
  }
}
