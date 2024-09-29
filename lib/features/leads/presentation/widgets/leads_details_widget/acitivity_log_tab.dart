import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/add_reminder_repository.dart';
import '../../cubit/activity_log_cubit.dart';

class ActivityLogTab extends StatelessWidget {
  final String leadId; // Pass the customerId to fetch specific activity logs

  const ActivityLogTab({super.key, required this.leadId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ActivityLogCubit(ApiServiceLog())..fetchActivityLogs(leadId),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<ActivityLogCubit, ActivityLogState>(
              builder: (context, state) {
                if (state is ActivityLogLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ActivityLogLoaded) {
                  return ListView.builder(
                    itemCount: state.logs.length,
                    itemBuilder: (context, index) {
                      final log = state.logs[index];
                      return Column(
                        children: log.activities.map((activity) {
                          return ActivityItem(
                            timeAgo: activity.date,
                            company: log.user,
                            action: activity.type,
                            isCreated: activity.type.contains('Created Lead'),
                            isFirst: log.activities.indexOf(activity) == 0,
                            isLast: log.activities.indexOf(activity) == log.activities.length - 1,
                            color: activity.type.contains('Created') ? Colors.green : Colors.grey,
                          );
                        }).toList(),
                      );
                    },
                  );
                } else if (state is ActivityLogError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ActivityItem extends StatelessWidget {
  final String timeAgo;
  final String company;
  final String action;
  final bool isCreated;
  final bool isFirst;
  final bool isLast;
  final Color color;

  const ActivityItem({
    super.key,
    required this.timeAgo,
    required this.company,
    required this.action,
    required this.isCreated,
    required this.isFirst,
    required this.isLast,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 20,
            child: Column(
              children: [
                if (!isFirst) Expanded(child: Container(width: 2, color: color)),
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                  ),
                ),
                if (!isLast) Expanded(child: Container(width: 2, color: color)),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    timeAgo,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.orange,
                        radius: 12,
                        child: Icon(Icons.person, size: 16, color: Colors.white),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: [
                              TextSpan(
                                text: '$company ',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: isCreated ? '- ' : ''),
                              TextSpan(text: action),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
