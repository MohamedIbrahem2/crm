import 'package:flutter/material.dart';

class ActivityLogTab extends StatelessWidget {
  const ActivityLogTab({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    ActivityItem(
                      timeAgo: '3 Days ago',
                      action: 'Created Lead',
                      isCreated: true,
                    ),
                    ActivityItem(
                      timeAgo: '3 Days ago',
                      action: 'updated lead status from New Lead From Campaign to Not Qualified',
                      isCreated: false,
                    ),
                    ActivityItem(
                      timeAgo: '3 Days ago',
                      action: 'updated lead status from New Lead From Campaign to Not Qualified',
                      isCreated: false,
                    ),
                    ActivityItem(
                      timeAgo: '3 Days ago',
                      action: 'Created Lead',
                      isCreated: true,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Enter Activity',
                    contentPadding: EdgeInsets.all(12),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Save'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
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
  final String action;
  final bool isCreated;

  const ActivityItem({
    Key? key,
    required this.timeAgo,
    required this.action,
    required this.isCreated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
              ),
              Container(
                width: 2,
                height: 40,
                color: Colors.grey[300],
              ),
            ],
          ),
          SizedBox(width: 16),
          Expanded(
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
                SizedBox(height: 4),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.orange,
                      radius: 12,
                      child: Icon(Icons.person, size: 16, color: Colors.white),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: [
                            TextSpan(
                              text: 'Go Grow ',
                              style: TextStyle(fontWeight: FontWeight.bold),
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
        ],
      ),
    );
  }
}