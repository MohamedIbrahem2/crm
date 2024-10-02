import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../../core/networking/api_constants.dart';
import '../../data/models/add_drop_down_model.dart';
import 'add_drop_down_state.dart';

enum DropdownType { status, source, country, product,productType,assigned}
class DropdownCubit extends Cubit<DropdownState> {
  DropdownCubit() : super(DropdownInitial());

  Future<void> fetchDropdownData(String endpoint,String name, DropdownType type) async {
    emit(DropdownLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final response = await http.get(
        Uri.parse(endpoint),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      final data = json.decode(response.body);
      if (data['status'] == 'success') {
        List<DropdownItem> dropdownItems = (data['data'] as List)
            .map((item) => DropdownItem(id: item['id'], name: item[name]))
            .toList();

        // Emit the correct state based on DropdownType

            emit(SourceDropdownLoaded(dropdownItems));
            emit(AssignedDropdownLoaded(dropdownItems));
            emit(CountryDropdownLoaded(dropdownItems));
            emit(ProductTypeDropdownLoaded(dropdownItems));
            emit(ProductDropdownLoaded(dropdownItems));
        emit(StatusDropdownLoaded(dropdownItems));


      } else {
        emit(DropdownError('Failed to load data'));
      }
    } catch (error) {
      emit(DropdownError(error.toString()));
    }
  }

}
