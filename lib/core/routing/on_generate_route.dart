
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sales_crm/core/routing/app_routes.dart';
import 'package:sales_crm/features/auth/presentation/pages/auth_page.dart';
import 'package:sales_crm/features/leads/presentation/pages/leads_page.dart';

import '../../features/leads/presentation/pages/laeds_details_page.dart';
import '../../features/leads/presentation/pages/laeds_details_page.dart';
import '../../features/leads/presentation/widgets/laeds_import/leads_imoprt.dart';
import '../../features/leads/presentation/widgets/leads_details_widget/reminders_tab/add_reminder.dart';
import '../../features/leads/presentation/widgets/leads_details_widget/reminders_tab/reminders_tab.dart';
import '../../features/leads/presentation/widgets/leads_widgets/add_lead_widget.dart';
import '../../features/projects/presentation/pages/project_page.dart';



class OnGenerateRoute {
  static Route<dynamic>? routes(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.authRoute:
        return MaterialPageRoute(
          builder: (_) => const AuthPage(),
          settings: settings,
        );
      case AppRoutes.leadsRoute:
        return MaterialPageRoute(
          builder: (_) => const LeadsPage(),
          settings: settings,
        );
      case AppRoutes.leadsDetailsRoute:
        return MaterialPageRoute(
          builder: (_) =>  LeadDetailsScreen(),
          settings: settings,
        );
      case AppRoutes.leadsAddRoute:
        return MaterialPageRoute(
          builder: (_) =>  const AddLeadScreen(),
          settings: settings,
        );
      case AppRoutes.leadsAddReminderRoute:
        return MaterialPageRoute(
          builder: (_) =>  const AddReminder(),
          settings: settings,
        );
      case AppRoutes.leadsImportRoute:
        return MaterialPageRoute(
          builder: (_) =>  const LeadImport(),
          settings: settings,
        );
      case AppRoutes.projectRoute:
        return MaterialPageRoute(
          builder: (_) =>  const ProjectPage(),
          settings: settings,
        );

    }
    return null;
  }
}
