import 'package:crm/features/leads/data/repositories/add_reminder_repository.dart';
import 'package:crm/features/leads/data/repositories/assigned_users_repository.dart';
import 'package:crm/features/leads/data/repositories/note_repository.dart';
import 'package:crm/features/leads/data/repositories/remienders_repository.dart';
import 'package:crm/features/leads/presentation/cubit/activity_log_cubit.dart';
import 'package:crm/features/leads/presentation/cubit/add_note_cubit.dart';
import 'package:crm/features/leads/presentation/cubit/add_remienders_cubit.dart';
import 'package:crm/features/leads/presentation/cubit/assigned_users_cubit.dart';
import 'package:crm/features/leads/presentation/cubit/note_cubit.dart';
import 'package:crm/features/leads/presentation/cubit/reminders_cubit.dart';
import 'package:crm/features/profile/presentation/cubit/fileUploadImage.dart';
import 'package:crm/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:crm/features/todo/presentation/cubit/todo_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:crm/core/helpers/extensions.dart';
import 'package:crm/core/routing/app_routes.dart';
import 'package:crm/core/routing/on_generate_route.dart';
import 'package:crm/core/services/services_locator.dart';

import '../features/auth/presentation/cubit/login_cubit/login_cubit.dart';
import '../features/leads/data/repositories/leads_repository.dart';
import '../features/leads/presentation/cubit/add_drop_down_cubit.dart';
import '../features/leads/presentation/cubit/leads_cubit.dart';

class SalesCrmApp extends StatefulWidget {
  const SalesCrmApp({super.key});

  @override
  State<SalesCrmApp> createState() => _SalesCrmAppState();
}

class _SalesCrmAppState extends State<SalesCrmApp> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<LoginCubit>()..checkIfLoggedIn(),),
        BlocProvider(
          create: (context) => LeadsCubit(LeadsRepository()),
        ),
        BlocProvider(
          create: (context) => AddRemindersCubit(AddReminderRepository(ApiServiceAdd())),
        ),
        BlocProvider<AssignedUsersCubit>(
          create: (_) => AssignedUsersCubit(),
        ),
        BlocProvider<NoteCubit>(
          create: (_) => NoteCubit(NoteRepository(ApiServiceNote())),
        ),
        BlocProvider<AddNoteCubit>(
          create: (_) => AddNoteCubit(NoteRepository(ApiServiceNote())),
        ),
        BlocProvider<ActivityLogCubit>(
          create: (_) => ActivityLogCubit(ApiServiceLog()),
        ),
        BlocProvider<ToDoCubit>(
          create: (_) => ToDoCubit(),
        ),
        BlocProvider<RemindersCubit>(
          create: (_) => RemindersCubit(ReminderRepository(ApiService())),
        ),
        BlocProvider<ProfileCubit>(
          create: (_) => ProfileCubit(),
        ),
        BlocProvider<FileUploadImageCubit>(
          create: (_) => FileUploadImageCubit(),
        ),
        BlocProvider<DropdownCubit2>(
          create: (_) => DropdownCubit2(),
        ),
        BlocProvider<DropdownCubit>(
          create: (_) => DropdownCubit(),
        ),
        BlocProvider<DropdownCubit3>(
          create: (_) => DropdownCubit3(),
        ),
        BlocProvider<DropdownCubit4>(
          create: (_) => DropdownCubit4(),
        ),
        BlocProvider<DropdownCubit5>(
          create: (_) => DropdownCubit5(),
        ),
        BlocProvider<DropdownCubit6>(
          create: (_) => DropdownCubit6(),
        ),
      ],
      child: ScreenUtilInit(
        useInheritedMediaQuery: true,
        builder: (context, child) {
          return BlocListener<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                navigatorKey.currentState!.pushReplacementNamed(AppRoutes.leadsRoute);
              }
            },
            child: MaterialApp(
              navigatorKey: navigatorKey,
              title: 'Sales CRM',
              debugShowCheckedModeBanner: false,
              initialRoute: AppRoutes.authRoute,
              theme: ThemeData.light().copyWith(
                primaryColor: Colors.white,
                scaffoldBackgroundColor: Colors.white,
              ),
              onGenerateRoute: OnGenerateRoute.routes,
            ),
          );
        },
      ),
    );
  }
}