
import 'package:flutter/material.dart';
import 'package:crm/core/routing/app_routes.dart';
import 'package:crm/features/auth/presentation/pages/auth_page.dart';
import 'package:crm/features/leads/presentation/pages/leads_page.dart';

import '../../features/calendar/presentation/pages/calendar_page.dart';
import '../../features/chat/presentation/pages/chat_page.dart';
import '../../features/leads/presentation/pages/laeds_details_page.dart';
import '../../features/leads/presentation/widgets/laeds_import/leads_imoprt.dart';
import '../../features/leads/presentation/widgets/leads_details_widget/reminders_tab/add_reminder.dart';
import '../../features/leads/presentation/widgets/leads_widgets/add_lead_widget.dart';
import '../../features/projects/presentation/pages/project_page.dart';
import '../../features/tickets/presentation/pages/tickets_details_page.dart';
import '../../features/tickets/presentation/pages/tickets_page.dart';
import '../../features/todo/presentation/pages/todo_page.dart';



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
        // return MaterialPageRoute(
        //   builder: (_) =>  const LeadDetailsScreen(),
        //   settings: settings,
        // );
      case AppRoutes.leadsAddRoute:
        return MaterialPageRoute(
          builder: (_) =>  const AddLeadScreen(),
          settings: settings,
        );
      // case AppRoutes.leadsAddReminderRoute:
      //   return MaterialPageRoute(
      //     builder: (_) =>  const AddReminder(),
      //     settings: settings,
      //   );
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
      case AppRoutes.chatRoute:
        return MaterialPageRoute(
          builder: (_) =>  const ChatPage(),
          settings: settings,
        );
      case AppRoutes.ticketsRoute:
        return MaterialPageRoute(
          builder: (_) =>   const TicketsPage(),
          settings: settings,
        );
      case AppRoutes.ticketsDetailsRoute:
        return MaterialPageRoute(
          builder: (_) =>  const  TicketsDetailsPage(),
          settings: settings,
        );
      case AppRoutes.calendarRoute:
        return MaterialPageRoute(
          builder: (_) =>    const CalendarPage(),
          settings: settings,
        );
      case AppRoutes.todoRoute:
        return MaterialPageRoute(
          builder: (_) =>   const ToDoPage(),
          settings: settings,
        );

    }
    return null;
  }
}
