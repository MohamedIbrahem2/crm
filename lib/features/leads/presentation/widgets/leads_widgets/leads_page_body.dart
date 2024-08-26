import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sales_crm/features/leads/presentation/widgets/leads_widgets/summary_card_widget.dart';

import 'lead_item_widget.dart';


class LeadsPageBody extends StatelessWidget {
  final ScrollController scrollController;
    LeadsPageBody({super.key, required this.scrollController});


  final Random _random = Random();
  Color _getRandomColor() {
    return Color.fromARGB(
      255,
      _random.nextInt(256),
      _random.nextInt(256),
      _random.nextInt(256),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitleWidget(
              'Summary',
              15,
              FontWeight.bold,
            ),
            SizedBox(height: 5.h),
            GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 2,
              childAspectRatio: 1.6,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: const [
                SummaryCard(
                  iconColor: Colors.green,
                  title: 'New leads_widgets',
                  value: '22',
                ),
                SummaryCard(
                  iconColor: Colors.red,
                  title: 'Contacted Leads',
                  value: '4',
                ),
                SummaryCard(
                  iconColor: Colors.green,
                  title: 'Qualified Leads',
                  value: '4',
                ),
                SummaryCard(
                  iconColor: Colors.red,
                  title: 'Negotiation',
                  value: '0',
                ),
                SummaryCard(
                  iconColor: Colors.orange,
                  title: 'Closed won',
                  value: '1',
                ),
                SummaryCard(
                  iconColor: Colors.blue,
                  title: 'Closed lost',
                  value: '26',
                ),
              ],
            ),
            SizedBox(height: 5.h),
            _buildTitleWidget(
              'Leads',
              15,
              FontWeight.bold,
            ),
            SizedBox(height: 5.h),
            Expanded(
                child: ListView.separated(
                    controller: scrollController,
                    itemBuilder: (context, index) => LeadItem(
                      name: 'John Smith',
                      position: 'CEO',
                      company: 'SmithTech Solutions',
                      amount: 7500.00,
                      source: 'Google',
                      status: 'Reopened',
                      date: '05 Apr 2024',
                      color: _getRandomColor(),
                    ),
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 4.h),
                    itemCount: 10),
              )
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


}


