import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON encoding/decoding
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/todo_model.dart';

class ToDoState extends Equatable {
  @override
  List<Object> get props => [];
}

class ToDoInitial extends ToDoState {}

class ToDoLoading extends ToDoState {}

class ToDoLoaded extends ToDoState {
  final List<ToDo> todos;
  final Map<String, int> statusCounts;

  ToDoLoaded(this.todos, this.statusCounts);

  @override
  List<Object> get props => [todos];
}

class ToDoError extends ToDoState {
  final String error;

  ToDoError(this.error);

  @override
  List<Object> get props => [error];
}

class ToDoCubit extends Cubit<ToDoState> {
  ToDoCubit() : super(ToDoInitial());

  final String baseUrl = "https://backcrm.growcrm.tech";
  // Fetch all ToDos
  Future<void> fetchToDos() async {
    print('Fetching ToDos...'); // Debugging statement
    emit(ToDoLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final moduleId = prefs.getString('moduleId');
      final token = prefs.getString('token');
      final response = await http.get(Uri.parse("$baseUrl/api/modules/$moduleId/todos"),headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });


      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body)['data'];
        print('Parsed JSON data: $jsonData'); // Debugging parsed JSON

        final List<ToDo> todos = jsonData.map((json) => ToDo.fromJson(json)).toList();
        final statusCounts = await ToDoCubit().fetchTodoStatus();
        emit(ToDoLoaded(todos,statusCounts));
      } else {
        emit(ToDoError("Failed to fetch ToDos"));
      }
    } catch (e) {
      print('Exception: $e'); // Catching and printing exception
      emit(ToDoError(e.toString()));
    }
  }

  // Add new ToDo
  Future<void> addToDo(ToDo newToDo) async {
    emit(ToDoLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final moduleId = prefs.getString('moduleId');
      final token = prefs.getString('token');
      final response = await http.post(
        Uri.parse('$baseUrl/api/modules/$moduleId/todos'),
        headers: {'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(newToDo.toJson()),
      );




      if (response.statusCode == 201) {
        fetchToDos(); // Refresh the list after adding a new task
      } else {
        emit(ToDoError("Failed to add ToDo"));
      }
    } catch (e) {
      print('Exception: $e');
      emit(ToDoError(e.toString()));
    }
  }

  // Update an existing ToDo
  Future<void> updateToDo(ToDo updatedToDo) async {
    emit(ToDoLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final moduleId = prefs.getString('moduleId');
      final token = prefs.getString('token');
      final response = await http.put(
        Uri.parse("$baseUrl/api/modules/$moduleId/todos/${updatedToDo.id}"),
        headers: {'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode(updatedToDo.toJson()),
      );


      if (response.statusCode == 200 || response.statusCode == 201) {
        fetchToDos(); // Refresh the list after updating
      } else {
        emit(ToDoError("Failed to update ToDo"));
      }
    } catch (e) {
      print('Exception: $e');
      emit(ToDoError(e.toString()));
    }
  }
  Future<void> toggleToDo(ToDo updatedToDo) async {
    emit(ToDoLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final moduleId = prefs.getString('moduleId');
      final token = prefs.getString('token');
      final response = await http.patch(
        Uri.parse("$baseUrl/api/modules/$moduleId/todos/${updatedToDo.id}/toggle"),
        headers: {'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode(updatedToDo.toJson()),
      );



      if (response.statusCode == 200) {
        fetchToDos(); // Refresh the list after updating
      } else {
        emit(ToDoError("Failed to update ToDo"));
      }
    } catch (e) {
      print('Exception: $e');
      emit(ToDoError(e.toString()));
    }
  }

  // Delete a ToDo
  Future<void> deleteToDo(int id) async {
    emit(ToDoLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final moduleId = prefs.getString('moduleId');
      final token = prefs.getString('token');
      final response = await http.delete(Uri.parse("$baseUrl/api/modules/$moduleId/todos/$id"),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          }
      );

      if (response.statusCode == 200) {
        fetchToDos(); // Refresh the list after deleting
      } else {
        emit(ToDoError("Failed to delete ToDo"));
      }
    } catch (e) {
      print('Exception: $e');
      emit(ToDoError(e.toString()));
    }
  }
  Future<Map<String, int>> fetchTodoStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final moduleId = prefs.getString('moduleId');
    final response = await http.get(
      Uri.parse('$baseUrl/api/modules/$moduleId/todos'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      if (data.containsKey('completed_count') &&
          data.containsKey('incompleted_count')) {

        return {
          'completed_count': data['completed_count'],
          'incompleted_count': data['incompleted_count']
        };
      } else {
        throw Exception('Data key is missing or null in the response.');
      }
    } else {
      throw Exception('Failed to load status counts: ${response.statusCode}');
    }
  }
}
