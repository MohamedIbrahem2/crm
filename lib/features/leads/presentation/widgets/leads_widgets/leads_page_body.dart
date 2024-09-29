import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:crm/features/leads/data/repositories/leads_repository.dart';
import 'package:crm/features/leads/presentation/cubit/leads_cubit.dart';
import 'package:crm/features/leads/presentation/widgets/leads_widgets/summary_card_widget.dart';

import '../../cubit/leads_states.dart';
import '../../cubit/status_cubit.dart';
import '../../cubit/status_state.dart';
import '../../pages/laeds_details_page.dart';
import 'lead_item_widget.dart';

class LeadsPageBody extends StatefulWidget {
  final ScrollController scrollController;

  const LeadsPageBody({super.key, required this.scrollController});

  @override
  State<LeadsPageBody> createState() => _LeadsPageBodyState();
}


class _LeadsPageBodyState extends State<LeadsPageBody> {
  @override
  void initState() {
    super.initState();
    context.read<StatusCubit>().fetchStatusCounts();
    context.read<LeadsCubit>().fetchLeads(); // Only call it here
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitleWidget('Leads Status', 15, FontWeight.bold),
            SizedBox(height: 5.h),
          GridView.count(
            crossAxisCount: 1,
            crossAxisSpacing: 1,
            mainAxisSpacing: 2,
            childAspectRatio: 4,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              BlocBuilder<StatusCubit, StatusState>(
                builder: (context, state) {
                  if (state is StatusLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is StatusLoaded) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SummaryCard(
                            iconColor: Colors.green,
                            title: 'Converted Customers',
                            value: state.statusCounts['converted_customers'].toString(),
                          ),
                        ),
                        Expanded(
                          child: SummaryCard(
                            iconColor: Colors.red,
                            title: 'leads in processing',
                            value: state.statusCounts['leads_in_processing'].toString(),
                          ),
                        ),
                        Expanded(
                          child: SummaryCard(
                            iconColor: Colors.green,
                            title: 'lost leads',
                            value: state.statusCounts['lost_leads'].toString(),
                          ),
                        ),
                      ],
                    );
                  } else if (state is StatusError) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SummaryCard(
                            iconColor: Colors.green,
                            title: 'Error',
                            value: '22',
                          ),
                        ),
                        Expanded(
                          child: SummaryCard(
                            iconColor: Colors.red,
                            title: 'Error',
                            value: '4',
                          ),
                        ),
                        Expanded(
                          child: SummaryCard(
                            iconColor: Colors.green,
                            title: 'Error',
                            value: '4',
                          ),
                        ),
                      ],
                    );
                  }
                  return const Center(child: Text('Status not available'));
                },
              ),
            ],
          ),

          SizedBox(height: 5.h),
            _buildTitleWidget('Leads', 15, FontWeight.bold),
            SizedBox(height: 5.h),
            Expanded(
              child: BlocListener<LeadsCubit, LeadsState>(
                listener: (context, state) {
                  if (state is LeadsError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                child: BlocBuilder<LeadsCubit, LeadsState>(
                  builder: (context, state) {
                    if (state is LeadsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is LeadsLoaded) {
                      if (state.leads.isNotEmpty) {
                        return RepaintBoundary(
                          child: ListView.builder(
                            controller: widget.scrollController,
                            itemCount: state.leads.length,
                            itemBuilder: (context, index) {
                              final lead = state.leads[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => LeadDetailsScreen(lead: lead)));
                                },
                                child: LeadItem(
                                  name: lead.name,
                                  position: lead.position,
                                  company: lead.company,
                                  amount: lead.amount,
                                  source: "lead.source",
                                  status: lead.status,
                                  date: lead.date,
                                  color: _getRandomColor(),
                                  moduleId: lead.leadId,
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return const Center(child: Text('No leads available.'));
                      }
                    } else {
                      return const Center(child: Text('No leads available.'));
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildTitleWidget(String text, double fontSize, FontWeight fontWeight) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black,
        fontSize: fontSize.sp,
        fontWeight: fontWeight,
      ),
    );
  }

  Color _getRandomColor() {
    return Color.fromARGB(
      255,
      Random().nextInt(256),
      Random().nextInt(256),
      Random().nextInt(256),
    );
  }
}
