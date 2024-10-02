import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:crm/features/drawer/presentation/pages/drawer_page.dart';

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
  DateTime? _lastPressedAt;
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
    return WillPopScope(
      onWillPop: () async {
        // Check if the back button was pressed within the last 2 seconds
        if (_lastPressedAt == null || DateTime.now().difference(_lastPressedAt!) > Duration(seconds: 2)) {
          _lastPressedAt = DateTime.now();
          // Show the Snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Press back again to exit the app'),
              duration: Duration(seconds: 2),
            ),
          );
          return false; // Prevent the back navigation
        }
        return true; // Allow the back navigation (close the app)
      },
      child: Scaffold(
        drawer: const DrawerPage(),
        extendBodyBehindAppBar: false,
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 70),
          child: AppBar(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(25),
              ),
            ),
            backgroundColor: AppColors.primaryYellow,
            title: const Text('To Do List'),
          ),
        ),
        resizeToAvoidBottomInset: true,
        body: const ToDoPageBody(),
        floatingActionButton: ValueListenableBuilder<bool>(
          valueListenable: _isFabVisible,
          builder: (context, isVisible, child) {
            return AnimatedOpacity(
              opacity: isVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: FloatingActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return  TodoAddDialog(onSubmit: (_) {  },);
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
      ),
    );
  }
}
