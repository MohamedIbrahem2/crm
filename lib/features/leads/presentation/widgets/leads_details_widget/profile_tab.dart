import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final Map<String, TextEditingController> controllers = {};

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _setDefaultValues();
  }

  void _initializeControllers() {
    const fields = [
      'name', 'source', 'amount', 'assigned', 'status', 'date',
      'assignedName', 'leadValue', 'phone', 'website', 'address',
      'city', 'state', 'zipCode', 'country'
    ];
    for (var field in fields) {
      controllers[field] = TextEditingController();
    }
  }

  void _setDefaultValues() {
    controllers['name']?.text = 'John Smith';
    controllers['source']?.text = 'CEO';
    controllers['amount']?.text = '7500.00';
    controllers['assigned']?.text = 'Google';
    controllers['status']?.text = 'Reopened';
    controllers['date']?.text = '05 Apr 2024';
    controllers['assignedName']?.text = 'SmithTech Solutions';
    controllers['phone']?.text = '+1 (123) 456-7890';
    controllers['website']?.text = 'https://www.exampleco.com';
    controllers['address']?.text = '456 Oak Street';
    controllers['city']?.text = 'San Francisco';
    controllers['state']?.text = 'CA';
    controllers['zipCode']?.text = '94110';
    controllers['country']?.text = '236';
  }

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
            _buildInfoCard('Company', controllers['assignedName']!, 'Lead Value', controllers['leadValue']!),
            SizedBox(height: 14.h),
            _buildInfoCard('Phone', controllers['phone']!, 'Website', controllers['website']!),
            SizedBox(height: 14.h),
            _buildAddressCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRow(
              _buildInfoColumn('Name', controllers['name']!),
              _buildInfoColumn('Amount', controllers['amount']!),
            ),
            SizedBox(height: 5.h),
            _buildRow(
              _buildInfoColumn('Source', controllers['source']!),
              _buildInfoColumn('Assigned', controllers['assigned']!),
            ),
            SizedBox(height: 5.h),
            _buildRow(
              _buildInfoColumn('Status', controllers['status']!),
              _buildInfoColumnWithIcon('Last Contact', controllers['date']!, Icons.calendar_today),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label1, TextEditingController controller1, String label2, TextEditingController controller2) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(child: _buildTextField(label1, controller1)),
            Expanded(child: _buildTextField(label2, controller2)),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField('Address', controllers['address']!),
            SizedBox(height: 14.h),
            _buildRow(
              _buildTextField('City', controllers['city']!),
              _buildTextField('State', controllers['state']!),
            ),
            SizedBox(height: 14.h),
            _buildRow(
              _buildTextField('Zip Code', controllers['zipCode']!),
              _buildTextField('Country', controllers['country']!),
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

  Widget _buildInfoColumn(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        TextField(
          controller: controller,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
          decoration: const InputDecoration(border: InputBorder.none),
        ),
      ],
    );
  }

  Widget _buildInfoColumnWithIcon(String label, TextEditingController controller, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(icon, color: Colors.blue),
            SizedBox(width: 8.w),
            Text(controller.text, style: const TextStyle(color: Colors.blue)),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        SizedBox(height: 4.h),
        TextField(
          controller: controller,
          style: const TextStyle(fontWeight: FontWeight.bold),
          decoration: const InputDecoration(border: InputBorder.none),
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
