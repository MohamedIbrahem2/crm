import 'package:flutter/material.dart';
import 'package:sales_crm/core/constants/app_colors.dart';
import 'package:sales_crm/core/helpers/extensions.dart';

import '../../../../../../core/routing/app_routes.dart';



class RemindersTab extends StatelessWidget {
  const RemindersTab({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: () {
                print('Close button pressed');
                context.pushNamed(AppRoutes.leadsAddReminderRoute);
              },
              icon: const Icon(Icons.notifications_active),
              label: const Text('Set Lead Reminder'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryYellow,
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('#')),
                  DataColumn(label: Text('Description')),
                  DataColumn(label: Text('Date')),
                  DataColumn(label: Text('Remind')),
                  DataColumn(label: Text('Is Notified?')),
                ],
                rows: const [
                  DataRow(cells: [
                    DataCell(Text('1')),
                    DataCell(Text(
                        'Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs.')),
                    DataCell(Text('2024-08-22 21:00:00')),
                    DataCell(Row(
                      children: [
                        Icon(Icons.notifications),
                        SizedBox(width: 4),
                        Text('Go Grow'),
                      ],
                    )),
                    DataCell(Text('No')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('2')),
                    DataCell(Text(
                        'Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs.')),
                    DataCell(Text('2024-08-22 21:00:00')),
                    DataCell(Row(
                      children: [
                        Icon(Icons.notifications),
                        SizedBox(width: 4),
                        Text('Go Grow'),
                      ],
                    )),
                    DataCell(Text('No')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('3')),
                    DataCell(Text(
                        'Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs.')),
                    DataCell(Text('2024-08-22 21:00:00')),
                    DataCell(Row(
                      children: [
                        Icon(Icons.notifications),
                        SizedBox(width: 4),
                        Text('Go Grow'),
                      ],
                    )),
                    DataCell(Text('No')),
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
