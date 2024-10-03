import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../../../core/networking/api_constants.dart';
import '../../data/models/add_drop_down_model.dart';
import 'add_drop_down_state.dart';

class DropdownCubit extends Cubit<DropdownState> {
  DropdownCubit() : super(DropdownInitial());

  Future<void> fetchDropdownData(String endpoint,String name) async {
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
        emit(DropdownLoaded(dropdownItems));


      } else {
        emit(DropdownError('Failed to load data'));
      }
    } catch (error) {
      emit(DropdownError(error.toString()));
    }
  }

}
class DropdownCubit2 extends Cubit<DropdownState2> {
  DropdownCubit2() : super(DropdownInitial2());

  Future<void> fetchDropdownData2(String endpoint,String name) async {
    emit(DropdownLoading2());

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
        emit(DropdownLoaded2(dropdownItems));


      } else {
        emit(DropdownError2('Failed to load data'));
      }
    } catch (error) {
      emit(DropdownError2(error.toString()));
    }
  }


}
class DropdownCubit3 extends Cubit<DropdownState3> {
  DropdownCubit3() : super(DropdownInitial3());

  Future<void> fetchDropdownData3(String endpoint,String name) async {
    emit(DropdownLoading3());

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
        emit(DropdownLoaded3(dropdownItems));


      } else {
        emit(DropdownError3('Failed to load data'));
      }
    } catch (error) {
      emit(DropdownError3(error.toString()));
    }
  }


}
class DropdownCubit4 extends Cubit<DropdownState4> {
  DropdownCubit4() : super(DropdownInitial4());

  Future<void> fetchDropdownData4(String endpoint,String name) async {
    emit(DropdownLoading4());

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
        emit(DropdownLoaded4(dropdownItems));


      } else {
        emit(DropdownError4('Failed to load data'));
      }
    } catch (error) {
      emit(DropdownError4(error.toString()));
    }
  }


}
class DropdownCubit5 extends Cubit<DropdownState5> {
  DropdownCubit5() : super(DropdownInitial5());

  Future<void> fetchDropdownData5(String endpoint,String name) async {
    emit(DropdownLoading5());

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
        emit(DropdownLoaded5(dropdownItems));


      } else {
        emit(DropdownError5('Failed to load data'));
      }
    } catch (error) {
      emit(DropdownError5(error.toString()));
    }
  }


}
class DropdownCubit6 extends Cubit<DropdownState6> {
  DropdownCubit6() : super(DropdownInitial6());

  Future<void> fetchDropdownData6(String endpoint,String name) async {
    emit(DropdownLoading6());

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
      print(response.body);
      final data = json.decode(response.body);
      if (data['status'] == 'success') {
        List<DropdownItem> dropdownItems = (data['data'] as List)
            .map((item) => DropdownItem(id: item['id'], name: item[name]))
            .toList();
        emit(DropdownLoaded6(dropdownItems));


      } else {
        emit(DropdownError6('Failed to load data'));
      }
    } catch (error) {
      emit(DropdownError6(error.toString()));
    }
  }


}
class DropdownSelectionCubit extends Cubit<int?> {
  DropdownSelectionCubit() : super(null);

  void selectValue(int? value) {
    emit(value);
  }
}

