import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sales_crm/core/constants/app_colors.dart';
import 'package:sales_crm/core/helpers/extensions.dart';
import 'package:sales_crm/core/routing/app_routes.dart';
import '../widgets/leads_page_body.dart';

class LeadsPage extends StatefulWidget {
  const LeadsPage({super.key});

  @override
  _LeadsPageState createState() => _LeadsPageState();
}

class _LeadsPageState extends State<LeadsPage> {
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
                context.pushNamed(AppRoutes.leadsAddRoute);
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