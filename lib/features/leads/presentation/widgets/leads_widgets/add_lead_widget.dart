import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sales_crm/core/constants/app_colors.dart';
import 'package:sales_crm/features/leads/presentation/cubit/add_leads_state.dart';
import '../../cubit/add_leads_cubit.dart';

class AddLeadScreen extends StatefulWidget {
  const AddLeadScreen({super.key});

  @override
  _AddLeadScreenState createState() => _AddLeadScreenState();
}

class _AddLeadScreenState extends State<AddLeadScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _needsController = TextEditingController();
  final TextEditingController _leadValueController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryIdController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _sourceIdController = TextEditingController();
  final TextEditingController _statusIdController = TextEditingController();
  final TextEditingController _assignedToController = TextEditingController();
  final TextEditingController _productRelatedIdController =
      TextEditingController();

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
    _positionController.dispose();
    _stateController.dispose();
    _countryIdController.dispose();
    _websiteController.dispose();
    _zipCodeController.dispose();
    _sourceIdController.dispose();
    _statusIdController.dispose();
    _assignedToController.dispose();
    _productRelatedIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Lead'),
        backgroundColor: AppColors.primaryYellow,
      ),
      body: SingleChildScrollView(
        child: BlocListener<AddLeadsCubit, AddLeadState>(
          listener: (context, state) {
            if (state is AddLeadLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) =>
                    const Center(child: CircularProgressIndicator()),
              );
            } else if (state is AddLeadSuccess) {
              Navigator.pop(context); // Close the loading indicator
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Lead added successfully!')),
              );
              Navigator.pop(context); // Go back to previous screen
            } else if (state is AddLeadError) {
              Navigator.pop(context); // Close the loading indicator
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to add lead: ${state.error}')),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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
                _buildTextField('Position', _positionController),
                SizedBox(height: 10.h),
                _buildTextField('State', _stateController),
                SizedBox(height: 10.h),
                _buildTextField('Country ID', _countryIdController),
                SizedBox(height: 10.h),
                _buildTextField('Website', _websiteController),
                SizedBox(height: 10.h),
                _buildTextField('Zip Code', _zipCodeController),
                SizedBox(height: 10.h),
                _buildTextField('Source ID', _sourceIdController),
                SizedBox(height: 10.h),
                _buildTextField('Status ID', _statusIdController),
                SizedBox(height: 10.h),
                _buildTextField('Assigned To', _assignedToController),
                SizedBox(height: 10.h),
                _buildTextField(
                    'Product Related ID', _productRelatedIdController),
                SizedBox(height: 10.h),
                ElevatedButton(
                  onPressed: () {
                    if (_validateFields()) {
                      context.read<AddLeadsCubit>().addLead(
                            name: _nameController.text,
                            phone: _phoneController.text,
                            email: _emailController.text,
                            company: _companyController.text,
                            city: _cityController.text,
                            address: _addressController.text,
                            needs: _needsController.text,
                            leadValue: int.tryParse(_leadValueController.text) ?? 0,
                            position: _positionController.text,
                            state: _stateController.text,
                            countryId:
                                int.tryParse(_countryIdController.text) ?? 0,
                            website: _websiteController.text,
                            zipCode: _zipCodeController.text,
                            sourceId:
                                int.tryParse(_sourceIdController.text) ?? 0,
                            statusId:
                                int.tryParse(_statusIdController.text) ?? 0,
                            assignedTo:
                                int.tryParse(_assignedToController.text) ?? 0,
                            productRelatedId: int.tryParse(
                                    _productRelatedIdController.text) ??
                                0,
                          );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Please fill all the fields')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryYellow,
                    minimumSize: const Size(double.infinity, 48),
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
        border: const OutlineInputBorder(),
      ),
    );
  }

  bool _validateFields() {
    if (_nameController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _companyController.text.isEmpty ||
        _cityController.text.isEmpty ||
        _addressController.text.isEmpty ||
        _needsController.text.isEmpty ||
        _leadValueController.text.isEmpty) {
      return false;
    }
    return true;
  }
}
