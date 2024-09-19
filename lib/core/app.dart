import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:sales_crm/core/helpers/extensions.dart';
import 'package:sales_crm/core/routing/app_routes.dart';
import 'package:sales_crm/core/routing/on_generate_route.dart';
import 'package:sales_crm/core/services/services_locator.dart';

import '../features/auth/presentation/cubit/login_cubit/login_cubit.dart';

class SalesCrmApp extends StatelessWidget {
  const SalesCrmApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

    return BlocProvider(
      create: (context) => sl<LoginCubit>()..checkIfLoggedIn(),
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
              initialRoute: AppRoutes.leadsRoute,
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