import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:crm/core/constants/app_colors.dart';
import 'package:crm/core/helpers/extensions.dart';
import 'package:crm/core/routing/app_routes.dart';
import 'package:crm/features/drawer/presentation/pages/drawer_page.dart';
import 'package:crm/features/leads/presentation/cubit/proposal_cubit.dart';

import '../../data/repositories/add_leads_repository.dart';
import '../../data/repositories/leads_repository.dart';
import '../../data/repositories/status_repository.dart';
import '../cubit/add_leads_cubit.dart';
import '../cubit/leads_cubit.dart';
import '../cubit/status_cubit.dart';
import '../widgets/leads_widgets/add_lead_widget.dart';
import '../widgets/leads_widgets/leads_page_body.dart';

class LeadsPage extends StatefulWidget {
  const LeadsPage({super.key});

  @override
  _LeadsPageState createState() => _LeadsPageState();
}

class _LeadsPageState extends State<LeadsPage> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<bool> _isFabVisible = ValueNotifier(true);
  DateTime? _lastPressedAt;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        _isFabVisible.value = false;
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        _isFabVisible.value = true;
      }
    });
    context.read<LeadsCubit>().fetchLeads();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _isFabVisible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Check if the back button was pressed within the last 2 seconds
        if (_lastPressedAt == null || DateTime.now().difference(_lastPressedAt!) > Duration(seconds: 2)) {
          _lastPressedAt = DateTime.now();
          // Show the Snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Press back again to exit the app'),
              duration: Duration(seconds: 2),
            ),
          );
          return false; // Prevent the back navigation
        }
        return true; // Allow the back navigation (close the app)
      },
      child: Scaffold(
        drawer: const DrawerPage(),
        extendBodyBehindAppBar: false,
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 70),
          child: AppBar(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(25),
              ),
            ),
            backgroundColor: AppColors.primaryYellow,
            title: const Text('Leads'),
            // actions: [
            //   IconButton(
            //     icon: const Icon(Icons.upload_file),
            //     onPressed: () {
            //       context.pushNamed(AppRoutes.leadsImportRoute);
            //     },
            //   ),
            // ],
          ),
        ),
        resizeToAvoidBottomInset: true,
        body: RepositoryProvider(
          create: (context) => LeadsRepository(),
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    LeadsCubit(context.read<LeadsRepository>()..getLeads()),
              ),
              BlocProvider(
                create: (context) => StatusCubit(StatusRepository()),
              ),
              // BlocProvider(
              //   create: (context) => FileUploadCubit(),
              // ),
            ],
            child: LeadsPageBody(scrollController: _scrollController),
          ),
        ),
        floatingActionButton: ValueListenableBuilder<bool>(
          valueListenable: _isFabVisible,
          builder: (context, isVisible, child) {
            return AnimatedOpacity(
              opacity: isVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (context) => AddLeadsCubit(AddLeadsRepository()),
                        child: const AddLeadScreen(),
                      ),
                    ),
                  );
                },
                backgroundColor: AppColors.primaryYellow,
                child: const Icon(Icons.add),
              ),
            );
          },
        ),
      ),
    );
  }
}
