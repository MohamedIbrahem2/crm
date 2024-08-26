


import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../leads/presentation/widgets/leads_widgets/leads_page_body.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _isFabVisible = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        _isFabVisible.value = false;
      } else if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
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
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: AppColors.primaryYellow,
        title: const Text('Leads'),
      ),
      resizeToAvoidBottomInset: true,
      body: LeadsPageBody(scrollController: _scrollController),
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: _isFabVisible,
        builder: (context, isVisible, child) {
          return AnimatedOpacity(
            opacity: isVisible ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: FloatingActionButton(
              onPressed: () {
                // context.pushNamed(AppRoutes.leadsAddRoute);
              },
              backgroundColor: AppColors.primaryYellow,
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}