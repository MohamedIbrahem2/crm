import 'package:flutter/material.dart';

class ActivityLogTab extends StatelessWidget {
  const ActivityLogTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: const  [
                    ActivityItem(
                      timeAgo: '3 Days ago',
                      company: 'TechNova',
                      action: 'Created Lead',
                      isCreated: true,
                      isFirst: true,
                      isLast: false,
                      color: Colors.green,
                    ),
                    ActivityItem(
                      timeAgo: '3 Days ago',
                      company: 'EcoSolutions',
                      action: 'updated lead status from New',
                      isCreated: false,
                      isFirst: false,
                      isLast: false,
                      color: Colors.green,
                    ),
                    ActivityItem(
                      timeAgo: '3 Days ago',
                      company: 'FinanceHub',
                      action: 'updated lead status from New',
                      isCreated: false,
                      isFirst: false,
                      isLast: true,
                      color: Colors.white,
                    ),
                    ActivityItem(
                      timeAgo: '4 Days ago',
                      company: 'HealthCare Plus',
                      action: 'Created Lead',
                      isCreated: true,
                      isFirst: true,
                      isLast: false,
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ],
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
                if (!isFirst) Expanded(child: Container(width: 2, color: Colors.green)),
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