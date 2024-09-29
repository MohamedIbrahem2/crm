import 'package:crm/core/helpers/extensions.dart';
import 'package:crm/features/leads/presentation/widgets/leads_details_widget/reminders_tab/add_reminder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/routing/app_routes.dart';
import '../../../../data/models/leads_model.dart';
import '../../../../data/models/remienders_model.dart';
import '../../../../data/repositories/remienders_repository.dart';
import '../../../cubit/reminders_cubit.dart';

class RemindersTab extends StatelessWidget {
  final Lead lead;
  const RemindersTab({super.key, required this.lead});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RemindersCubit(ReminderRepository(ApiService()))..fetchReminders(lead.leadId),
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColors.primaryYellow,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddReminder(leadId: lead.leadId,)));
          },
          label: Row(
            children: [
              const Icon(Icons.notifications_active, color: Colors.black),
              const SizedBox(width: 5),
              const Text('Set Lead Reminder', style: TextStyle(color: Colors.black)),
            ],
          ),
        ),
        body: BlocBuilder<RemindersCubit, RemindersState>(
          builder: (context, state) {
            if (state is RemindersLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is RemindersLoaded) {
              return _buildRemindersTable(state.reminders);
            } else if (state is RemindersError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('No reminders found.'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildRemindersTable(List<ReminderModel> reminders) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('#')),
          DataColumn(label: Text('Description')),
          DataColumn(label: Text('Date')),
          DataColumn(label: Text('Remind To')),
          DataColumn(label: Text('Is Notified?')),
        ],
        rows: reminders
            .map(
              (reminder) => DataRow(cells: [
            DataCell(Text(reminder.id.toString())),
            DataCell(Text(reminder.description)),
            DataCell(Text(reminder.date)),
            DataCell(Text(reminder.remindTo)),
            DataCell(Text(reminder.isNotified)),
          ]),
        )
            .toList(),
      ),
    );
  }

}
