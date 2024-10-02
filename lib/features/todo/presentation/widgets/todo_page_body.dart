import 'package:crm/features/todo/presentation/widgets/todo_add.dart';
import 'package:crm/features/todo/presentation/widgets/todo_summary_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/todo_model.dart';
import '../cubit/todo_cubit.dart';
import '../widgets/todo_item.dart';

class ToDoPageBody extends StatefulWidget {
  const ToDoPageBody({super.key});

  @override
  State<ToDoPageBody> createState() => _ToDoPageBodyState();
}

class _ToDoPageBodyState extends State<ToDoPageBody> {
  @override
  void initState(){
    super.initState();
    context.read<ToDoCubit>().fetchToDos();
    context.read<ToDoCubit>().fetchTodoStatus();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<ToDoCubit, ToDoState>(
        builder: (context, state) {
          if (state is ToDoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ToDoLoaded) {
            return Column(
              children: [
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child:   ToDoSummaryHeader(all: state.todos.length,
                   complete: state.statusCounts['completed_count']!,
                   inComplete: state.statusCounts['incompleted_count']!,),
               ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.todos.length,
                    itemBuilder: (context, index) {
                      final todo = state.todos[index];
                      return ToDoItem(
                        title: todo.task,
                        description: 'Created on: ${todo.createdAt}',
                        status: 'Status: ${todo.updatedAt}',
                        progress: 0.5, // Example progress
                        date: todo.createdAt.toString(),
                        company: 'Company name',  // Replace with actual company info if available
                        color: Colors.orange, todo: todo,onEdit: (ToDo todo) {
                        _showEditDialog(context, todo);  // Trigger the edit dialog
                      }, // Customize the color
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is ToDoError) {
            return Center(child: Text(state.error));
          }
          return const SizedBox.shrink(); // Default state
        },
      ),
    );
  }
  void _showEditDialog(BuildContext context, ToDo todo) {
    showDialog(
      context: context,
      builder: (context) {
        return TodoAddDialog(
          todo: todo,
          onSubmit: (String task) {
            final updatedToDo = todo.copyWith(task: task);  // Update the task
            BlocProvider.of<ToDoCubit>(context).updateToDo(updatedToDo);
          },
        );
      },
    );
  }
}
