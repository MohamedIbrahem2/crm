
import 'package:flutter/material.dart';
import 'package:sales_crm/core/constants/app_assets.dart';
import 'package:sales_crm/core/helpers/extensions.dart';
import 'package:sales_crm/core/routing/app_routes.dart';

import '../../../../core/constants/app_colors.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children:  <Widget>[
           DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.white,
            ),
            child:Image.asset(AppAssets.drawerLogo,width: 100,height: 100,),
          ),
          ListTile(
            title: const Text('leads',style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),),
            leading: const Icon(Icons.leaderboard),
            onTap: () {
              context.pushNamed(AppRoutes.leadsRoute);
            },
          ),
          ListTile(
            title: const Text('chat',style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),),
            leading: const Icon(Icons.chat),
            onTap: () {
              context.pushNamed(AppRoutes.chatRoute);
            },
          ),
          ListTile(
            title: const Text('calender',style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),),
            leading: const Icon(Icons.calendar_today),
            onTap: () {
              context.pushNamed(AppRoutes.calendarRoute);
            },
          ),
          ListTile(
            title: const Text('tickets',style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),),
            leading: const Icon(Icons.confirmation_number),
            onTap: () {
              context.pushNamed(AppRoutes.ticketsRoute);
            },
          ),
          ListTile(
            title: const Text('ToDo',style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),),
            leading: const Icon(Icons.check_circle),
            onTap: () {
              context.pushNamed(AppRoutes.todoRoute);
            },
          ),
          ListTile(
            title: const Text('profile',style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),),
            leading: const Icon(Icons.person),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: const Text('logout',style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),),
            leading: const Icon(Icons.logout),
            onTap: () {
              context.pushNamedAndRemoveUntil(AppRoutes.authRoute, predicate: (route) => false );
            },
          ),
        ],
      ),
    );
  }
}
