import 'package:crm/core/networking/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crm/core/constants/app_colors.dart';
import 'package:crm/features/leads/presentation/cubit/add_leads_state.dart';
import '../../../data/models/add_drop_down_model.dart';
import '../../cubit/add_drop_down_cubit.dart';
import '../../cubit/add_drop_down_state.dart';
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

  int? selectedStatus;
  int? selectedSource;
  int? selectedAssignedTo;
  int? selectedCountry;
  int? selectedProductType;
  int? selectedProduct;
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
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 70),
        child: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(25),
            ),
          ),
          backgroundColor: AppColors.primaryYellow,
          title: const Text('Create new lead'),
        ),
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
                _buildTextField('Lead Value', _leadValueController),
                SizedBox(height: 10.h),
                _buildTextField('Position', _positionController),
                SizedBox(height: 10.h),
                _buildTextField('State', _stateController),
                SizedBox(height: 10.h),
                _buildTextField('Website', _websiteController),
                SizedBox(height: 10.h),
                _buildTextField('Zip Code', _zipCodeController),
                SizedBox(height: 10.h),
                // Dropdown for Status
                BlocProvider(
                  create: (context) => DropdownCubit(),
                  child: BlocBuilder<DropdownCubit, DropdownState>(
                    bloc: context.read<DropdownCubit>()
                      ..fetchDropdownData(
                          "${ApiConstants
                              .apiBaseUrl}/modules/1/lead-statuses/get",
                          "status_name"),
                    builder: (context, stateStatus) {
                      if (stateStatus is DropdownLoading) {
                        return const Center(
                            child: CircularProgressIndicator());
                      } else if (stateStatus is DropdownError) {
                        return Center(
                            child: Text('Error: ${stateStatus.error}'));
                      } else if (stateStatus is DropdownLoaded) {
                        print(stateStatus.dropdownItems.first);
                        final statusItems = stateStatus.dropdownItems;
                        return _buildDropdownField('Status', statusItems,
                                (value) {
                                selectedStatus = value;
                            });
                      }
                      return const Text(
                          "no"); // Fallback in case state doesn't match.
                    },
                  ),
                ),
                SizedBox(height: 10.h),

                // Dropdown for Source
                BlocProvider(
                  create: (context) => DropdownCubit2(),
                  child: BlocBuilder<DropdownCubit2, DropdownState2>(
                    bloc: context.read<DropdownCubit2>()
                      ..fetchDropdownData2(
                          "${ApiConstants
                              .apiBaseUrl}/modules/1/lead-sources/get",
                          "source_name"),
                    builder: (context, stateSource) {
                      if (stateSource is DropdownLoading2) {
                        return const Center(
                            child: CircularProgressIndicator());
                      } else if (stateSource is DropdownError2) {
                        return Center(
                            child: Text('Error: ${stateSource.error}'));
                      } else if (stateSource is DropdownLoaded2) {
                        print(stateSource.dropdownItems.first);
                        final sourceItems = stateSource.dropdownItems;
                        return _buildDropdownField('Source', sourceItems,
                                (value) {
                                selectedSource = value;
                            });
                      }
                      return const Text(
                          "no"); // Fallback in case state doesn't match.
                    },
                  ),
                ),
                SizedBox(height: 10.h),

                // Dropdown for Assigned To
                BlocProvider(
                  create: (context) => DropdownCubit3(),
                  child: BlocBuilder<DropdownCubit3, DropdownState3>(
                    bloc: context.read<DropdownCubit3>()
                      ..fetchDropdownData3(
                          "${ApiConstants
                              .apiBaseUrl}/users/assgined",
                          "name"),
                    builder: (context, stateAssigned) {
                      if (stateAssigned is DropdownLoading3) {
                        return const Center(
                            child: CircularProgressIndicator());
                      } else if (stateAssigned is DropdownError3) {
                        return Center(
                            child: Text('Error: ${stateAssigned.error}'));
                      } else if (stateAssigned is DropdownLoaded3) {
                        print(stateAssigned.dropdownItems.first);
                        final assignedItems = stateAssigned.dropdownItems;
                        return _buildDropdownField(
                            'Assigned To', assignedItems, (value) {
                            selectedAssignedTo = value;
                        });
                      }
                      return const Text(
                          "no"); // Fallback in case state doesn't match.
                    },
                  ),
                ),
                SizedBox(height: 10.h),

                // Dropdown for Country
                BlocProvider(
                  create: (context) => DropdownCubit4(),
                  child: BlocBuilder<DropdownCubit4, DropdownState4>(
                    bloc: context.read<DropdownCubit4>()
                      ..fetchDropdownData4(
                          "${ApiConstants.apiBaseUrl}/countries", "name"),
                    builder: (context, stateCountry) {
                      if (stateCountry is DropdownLoading4) {
                        return const Center(
                            child: CircularProgressIndicator());
                      } else if (stateCountry is DropdownError4) {
                        return Center(
                            child: Text('Error: ${stateCountry.error}'));
                      } else if (stateCountry is DropdownLoaded4) {
                        print(stateCountry.dropdownItems.first);
                        final countryItems = stateCountry.dropdownItems;
                        return _buildDropdownField('Country', countryItems,
                                (value) {
                                selectedCountry = value;
                            });
                      }
                      return const Text(
                          "no"); // Fallback in case state doesn't match.
                    },
                  ),
                ),
                SizedBox(height: 10.h),

                // Dropdown for Product Type
                BlocProvider(
                  create: (context) => DropdownCubit5(),
                  child: BlocBuilder<DropdownCubit5, DropdownState5>(
                    bloc: context.read<DropdownCubit5>()
                      ..fetchDropdownData5(
                        "${ApiConstants.apiBaseUrl}/module/product-types", // URL for product types
                        "name",),
                    builder: (context, stateProductType) {
                      if (stateProductType is DropdownLoading5) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (stateProductType is DropdownError5) {
                        return Center(child: Text('Error: ${stateProductType.error}'));
                      } else if (stateProductType is DropdownLoaded5) {
                        final productTypeItems = stateProductType.dropdownItems;

                        return _buildDropdownField(
                            'Product Type',
                            productTypeItems,
                                (value) {
                              selectedProductType = value;
                              context.read<DropdownCubit6>().fetchDropdownData6(
                                "${ApiConstants.apiBaseUrl}/module/1/product-types/$selectedProductType", // Fetch related products using product type ID
                                "label",
                              );
                            }
                        );
                      }
                      return const Text("no");
                    },
                  ),
                ),

                SizedBox(height: 10.h),

                // Dropdown for Product
                BlocProvider(
                  create: (context) => DropdownCubit6(),
                  child: BlocBuilder<DropdownCubit6, DropdownState6>(
                    bloc: context.read<DropdownCubit6>()..fetchDropdownData6(
                      "${ApiConstants.apiBaseUrl}/module/1/product-types/$selectedProductType", // Fetch related products using product type ID
                      "label",
                    ),
                    builder: (context, stateProduct) {
                      if (stateProduct is DropdownLoading6) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (stateProduct is DropdownError6) {
                        return Center(child: Text('Error: ${stateProduct.error}'));
                      } else if (stateProduct is DropdownLoaded6) {
                        final productItems = stateProduct.dropdownItems;

                        return _buildDropdownField('Product', productItems, (value) {
                          selectedProduct = value;  // Capture selected product ID
                        });
                      }
                      return const Text("no");
                    },
                  ),
                ),


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
                        leadValue: int.tryParse(_leadValueController.text) ?? 0,
                        position: _positionController.text,
                        state: _stateController.text,
                        countryId: selectedCountry ?? 0,
                        website: _websiteController.text,
                        zipCode: _zipCodeController.text,
                        sourceId: selectedSource ?? 0,
                        statusId: selectedStatus ?? 0,
                        assignedTo: selectedAssignedTo ?? 0,
                        productRelatedId: selectedProduct ?? 0,
                        productType: selectedProductType ?? 0,
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
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.black),
                  ),
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
        filled: true,
        fillColor: Colors.white,
        labelText: label,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.secondaryYellow,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondaryYellow, width: 2.0),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label, List<DropdownItem> items,
      Function(int?) onChanged) {
    return BlocProvider(
      create: (context) => DropdownSelectionCubit(),
      child: BlocBuilder<DropdownSelectionCubit, int?>(
        builder: (context, state) {
          return DropdownButtonFormField<int>(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              labelText: label,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: AppColors.secondaryYellow,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppColors.secondaryYellow, width: 2.0),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
            ),
            items: items.map((DropdownItem item) {
              return DropdownMenuItem<int>(
                value: item.id,
                child: Text(item.name),
              );
            }).toList(),
            onChanged: onChanged,
            isExpanded: true,
            hint: Text('Select $label'),
          );
        },
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
        _leadValueController.text.isEmpty ||
        selectedStatus == null ||
        selectedSource == null ||
        selectedAssignedTo == null ||
        selectedCountry == null ||
        selectedProductType == null ||
        selectedProduct == null) {
      return false;
    }
    return true;
  }
}
