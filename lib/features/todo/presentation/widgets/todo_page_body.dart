import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crm/features/todo/presentation/widgets/todo_item.dart';
import 'package:crm/features/todo/presentation/widgets/todo_summary_header.dart';

class ToDoPageBody extends StatelessWidget {
  final ScrollController scrollController;
  const ToDoPageBody({super.key, required this.scrollController});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const ToDoSummaryHeader(),
          SizedBox(height: 18.h),
          ListView.separated(
            controller: scrollController,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            separatorBuilder: (context, index) => SizedBox(height: 14.h),
            itemBuilder: (context, index) => const ToDoItem(
              title: 'Legal Consultation',
              description: 'Provide legal consultation...',
              status: 'On Hold',
              progress: 0.5,
              date: '2024-04-30',
              company: 'Branditta Solutions LTD',
              color: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}

