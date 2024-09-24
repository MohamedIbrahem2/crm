import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sales_crm/core/constants/app_colors.dart';
import 'package:sales_crm/features/leads/presentation/widgets/leads_details_widget/contract_tab.dart';

import '../../data/models/leads_model.dart';
import '../cubit/proposal_cubit.dart';
import '../widgets/leads_details_widget/acitivity_log_tab.dart';
import '../widgets/leads_details_widget/note_tap.dart';
import '../widgets/leads_details_widget/profile_tab.dart';
import '../widgets/leads_details_widget/proposals.dart';
import '../widgets/leads_details_widget/reminders_tab/reminders_tab.dart';
//import 'package:file_picker/file_picker.dart';

class LeadDetailsScreen extends StatefulWidget {
  final Lead lead;

  const LeadDetailsScreen({super.key, required this.lead});

  @override
  _LeadDetailsScreenState createState() => _LeadDetailsScreenState();
}

class _LeadDetailsScreenState extends State<LeadDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Map<String, TextEditingController> controllers = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  Future<void> _updateFromFile() async {
    try {
      // FilePickerResult? result = await FilePicker.platform.pickFiles();
      // if (result != null) {
      //   File file = File(result.files.single.path!);
      //   String contents = await file.readAsString();
      //
      //   contents.split('\n').forEach((line) {
      //     var parts = line.split(':');
      //     if (parts.length == 2 && controllers.containsKey(parts[0].trim())) {
      //       controllers[parts[0].trim()]!.text = parts[1].trim();
      //     }
      //   });
      //   setState(() {});
      // }
    } catch (e) {
      print('Error reading file: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error updating from file')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryYellow,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Lead Details'),
      ),
      body: Column(
        children: [
          TabBar(
            labelStyle: TextStyle(fontSize: 14.sp),
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            controller: _tabController,
            tabs: const [
              Tab(text: 'Profile'),
              Tab(text: 'Proposal'),
              Tab(text: 'Contract'),
              Tab(text: 'Reminders'),
              Tab(text: 'Notes'),
              Tab(text: 'Activity Log'),
            ],
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: AppColors.primaryYellow,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ProfileTab(lead: widget.lead,),
                BlocProvider(
                  create: (context) => FileUploadCubit(),
                  child: ProposalsTab(),
                ),
                ContractTab(),
                RemindersTab(),
                NoteTab(),
                ActivityLogTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }


  @override
  void dispose() {
    for (var controller in controllers.values) {
      controller.dispose();
    }
    _tabController.dispose();
    super.dispose();
  }
}
