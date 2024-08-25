
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sales_crm/core/routing/app_routes.dart';
import 'package:sales_crm/features/auth/presentation/pages/auth_page.dart';
import 'package:sales_crm/features/leads/presentation/pages/leads_page.dart';

import '../../features/leads/presentation/widgets/add_lead_widget.dart';



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
      case AppRoutes.leadsAddRoute:
        return MaterialPageRoute(
          builder: (_) =>  const AddLeadScreen(),
          settings: settings,
        );
    }
    return null;
  }
}
