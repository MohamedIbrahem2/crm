import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:sales_crm/core/routing/app_routes.dart';
import 'package:sales_crm/core/routing/on_generate_route.dart';

class SalesCrmApp extends StatelessWidget {
const SalesCrmApp({
  super.key,
});

@override
Widget build(BuildContext context) {
  return ScreenUtilInit(
    useInheritedMediaQuery: true,
    builder: (context, child) {
      return MaterialApp(
        title: 'Currency&Gold',
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.todoRoute,
        theme: ThemeData.light().copyWith(
          primaryColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
        ),
        onGenerateRoute: OnGenerateRoute.routes,
      );
    },
  );
  }
}