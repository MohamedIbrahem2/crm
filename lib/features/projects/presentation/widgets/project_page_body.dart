import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crm/features/projects/presentation/widgets/project_item.dart';
import 'package:crm/features/projects/presentation/widgets/project_summary_header.dart';

class ProjectPageBody extends StatelessWidget {
  final ScrollController scrollController;
  const ProjectPageBody({super.key, required this.scrollController});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const ProjectSummaryHeader(),
          SizedBox(height: 18.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Projects', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.filter_list),
                label: const Text('Filter'),
              ),
            ],
          ),
          ListView.separated(
            controller: scrollController,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            separatorBuilder: (context, index) => SizedBox(height: 14.h),
            itemBuilder: (context, index) => const ProjectItem(
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

