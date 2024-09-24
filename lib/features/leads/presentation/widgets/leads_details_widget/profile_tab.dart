import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/models/leads_model.dart';

class ProfileTab extends StatefulWidget {
  final Lead lead;
  const ProfileTab({super.key, required this.lead});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final Map<String, TextEditingController> controllers = {};

  @override
  void initState() {
    super.initState();
    // _initializeControllers();
    // _setDefaultValues();
  }

  // void _initializeControllers() {
  //   const fields = [
  //     'name', 'source', 'amount', 'assigned', 'status', 'date',
  //     'assignedName', 'leadValue', 'phone', 'website', 'address',
  //     'city', 'state', 'zipCode', 'country'
  //   ];
  //   for (var field in fields) {
  //     controllers[field] = TextEditingController();
  //   }
  // }

  // void _setDefaultValues() {
  //   controllers['name']?.text = 'John Smith';
  //   controllers['source']?.text = 'CEO';
  //   controllers['amount']?.text = '7500.00';
  //   controllers['assigned']?.text = 'Google';
  //   controllers['status']?.text = 'Reopened';
  //   controllers['date']?.text = '05 Apr 2024';
  //   controllers['assignedName']?.text = 'SmithTech Solutions';
  //   controllers['phone']?.text = '+1 (123) 456-7890';
  //   controllers['website']?.text = 'https://www.exampleco.com';
  //   controllers['address']?.text = '456 Oak Street';
  //   controllers['city']?.text = 'San Francisco';
  //   controllers['state']?.text = 'CA';
  //   controllers['zipCode']?.text = '94110';
  //   controllers['country']?.text = '236';
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProfileCard(),
            SizedBox(height: 14.h),
            _buildInfoCard('Company', widget.lead.company, 'Lead Value', widget.lead.amount.toString()),
            SizedBox(height: 14.h),
            _buildInfoCard('Phone', widget.lead.phone, 'Website', widget.lead.website),
            SizedBox(height: 14.h),
            _buildAddressCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRow(
              _buildInfoColumn('Name', widget.lead.name),
              _buildInfoColumn('Amount', widget.lead.amount.toString()),
            ),
            SizedBox(height: 5.h),
            _buildRow(
              _buildInfoColumn('Status', widget.lead.status),
              _buildInfoColumn('Needs', widget.lead.date),
            ),
            SizedBox(height: 5.h),
            _buildRow(
              _buildInfoColumn('Position', widget.lead.position),
              _buildInfoColumnWithIcon('Last Contact', "Never", Icons.calendar_today),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label1, String text, String label2, String text2) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(child: _buildTextField(label1, text)),
            Expanded(child: _buildTextField(label2, text2)),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressCard() {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField('Address', widget.lead.address),
            SizedBox(height: 14.h),
            _buildRow(
              _buildTextField('City', widget.lead.city),
              _buildTextField('State', widget.lead.state),
            ),
            SizedBox(height: 14.h),
            _buildRow(
              _buildTextField('Zip Code', widget.lead.zipcode),
              _buildTextField('Country', widget.lead.country),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(Widget left, Widget right) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: left),
        Expanded(child: right),
      ],
    );
  }

  Widget _buildInfoColumn(String label, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        Text(
          text,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildInfoColumnWithIcon(String label, String text, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(icon, color: Colors.blue),
            SizedBox(width: 8.w),
            Text(text, style: const TextStyle(color: Colors.blue)),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField(String label, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        SizedBox(height: 4.h),
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  @override
  void dispose() {
    for (var controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }
}
