import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sales_crm/core/app.dart';
import 'package:sales_crm/core/constants/app_colors.dart';

class AddLeadScreen extends StatefulWidget {
  const AddLeadScreen({super.key});
  @override
  _AddLeadScreenState createState() => _AddLeadScreenState();
}

class _AddLeadScreenState extends State<AddLeadScreen> {
  late TextEditingController _nameController = TextEditingController();
  late TextEditingController _phoneController = TextEditingController();
  late TextEditingController _emailController = TextEditingController();
  late TextEditingController _companyController = TextEditingController();
  late TextEditingController _cityController = TextEditingController();
  late TextEditingController _addressController = TextEditingController();
  late TextEditingController _needsController = TextEditingController();
  late TextEditingController _leadValueController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _companyController = TextEditingController();
    _cityController = TextEditingController();
    _addressController = TextEditingController();
    _needsController = TextEditingController();
    _leadValueController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _companyController.dispose();
    _cityController.dispose();
    _addressController.dispose();
    _needsController.dispose();
    _leadValueController.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Lead'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
        backgroundColor: AppColors.primaryYellow
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTextField('Name', _nameController),
                SizedBox(height: 10.h),
                _buildTextField('Phone', _phoneController),
                SizedBox(height: 10.h),
                _buildTextField('Email', _emailController),
                SizedBox(height: 10.h),
                _buildTextField('Company', _companyController),
                SizedBox(height: 10.h),
                _buildTextField('City', _cityController),
                SizedBox(height: 10.h),
                _buildTextField('Address', _addressController),
                SizedBox(height: 10.h),
                _buildTextField('Needs', _needsController),
                SizedBox(height: 10.h),
                _buildTextField('Lead Value', _leadValueController),
                SizedBox(height: 10.h),
                ElevatedButton(
                  onPressed: () {
                    // Handle form submission
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryYellow, // Button color
                     // Background color
                    minimumSize: const Size(double.infinity, 48), // Full-width button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }
}