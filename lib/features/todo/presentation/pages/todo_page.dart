import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sales_crm/features/drawer/presentation/pages/drawer_page.dart';

import '../../../../core/constants/app_colors.dart';
import '../widgets/todo_add.dart';
import '../widgets/todo_page_body.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  _ToDoPageState createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _isFabVisible = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        _isFabVisible.value = false;
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        _isFabVisible.value = true;
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _isFabVisible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerPage(),
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: AppColors.primaryYellow,
        title: const Text('To Do List'),
      ),
      resizeToAvoidBottomInset: true,
      body: ToDoPageBody(scrollController: _scrollController),
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: _isFabVisible,
        builder: (context, isVisible, child) {
          return AnimatedOpacity(
            opacity: isVisible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: FloatingActionButton(
              onPressed: () {
                // Show the dialog to add a new note
                showDialog(
                  context: context,
                  builder: (context) {
                    return const TodoAddDialog();
                  },
                );
              },
              backgroundColor: AppColors.primaryYellow,
              child: const Icon(
                Icons.add,
              ),
            ),
          );
        },
      ),
    );
  }
}
