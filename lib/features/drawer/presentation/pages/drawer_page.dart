
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sales_crm/core/constants/app_assets.dart';
import 'package:sales_crm/core/helpers/extensions.dart';
import 'package:sales_crm/core/routing/app_routes.dart';

import '../../../../core/constants/app_colors.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              padding: const EdgeInsets.all(45),
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                      ),
              child: Image.asset(AppAssets.appLogo,width: 100,height: 100,)),
        ListTile(
            title: const Text(
              'leads',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            leading: const Icon(Icons.leaderboard_outlined),
            onTap: () {
              context.pushNamed(AppRoutes.leadsRoute);
            },
          ),
          ListTile(
            title: const Text(
              'chat',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            leading: const Icon(Icons.chat_bubble_outline),
            onTap: () {
              context.pushNamed(AppRoutes.leadsRoute);
            },
          ),
          ListTile(
            title: const Text(
              'calender',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            leading: const Icon(Icons.calendar_today),
            onTap: () {
              context.pushNamed(AppRoutes.leadsRoute);
            },
          ),
          ListTile(
            title: const Text(
              'tickets',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            leading: const Icon(Icons.confirmation_number_outlined),
            onTap: () {
              context.pushNamed(AppRoutes.leadsRoute);
            },
          ),
          ListTile(
            title: const Text(
              'ToDo',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            leading: const Icon(Icons.check_circle_outline),
            onTap: () {
              context.pushNamed(AppRoutes.leadsRoute);
            },
          ),
          ListTile(
            title: const Text(
              'profile',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            leading: const Icon(Icons.person_2_outlined),
            onTap: () {
              context.pushNamed(AppRoutes.leadsRoute);
            },
          ),
          GestureDetector(
            onTap: () {},
            child: ListTile(
              leading: const Icon(Icons.logout_outlined),
              title: Text(
                'log out',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
    // return Drawer(
    //   width: 200,
    //   backgroundColor: AppColors.white,
    //   child: ListView(
    //     padding: EdgeInsets.zero,
    //     children:  <Widget>[
    //        DrawerHeader(
    //          padding: const EdgeInsets.all(45),
    //         decoration: const BoxDecoration(
    //           color: AppColors.white,
    //         ),
    //         child:Image.asset(AppAssets.appLogo,width: 100,height: 100,),
    //       ),
    //       ListTile(
    //         title: const Text('leads',style: TextStyle(
    //           color: Colors.black,
    //           fontSize: 20,
    //         ),),
    //         leading: const Icon(Icons.leaderboard),
    //         onTap: () {
    //           context.pushNamed(AppRoutes.leadsRoute);
    //         },
    //       ),
    //       ListTile(
    //         title: const Text('chat',style: TextStyle(
    //           color: Colors.black,
    //           fontSize: 20,
    //         ),),
    //         leading: const Icon(Icons.chat),
    //         onTap: () {
    //           context.pushNamed(AppRoutes.chatRoute);
    //         },
    //       ),
    //       ListTile(
    //         title: const Text('calender',style: TextStyle(
    //           color: Colors.black,
    //           fontSize: 20,
    //         ),),
    //         leading: const Icon(Icons.calendar_today),
    //         onTap: () {
    //           context.pushNamed(AppRoutes.calendarRoute);
    //         },
    //       ),
    //       ListTile(
    //         title: const Text('tickets',style: TextStyle(
    //           color: Colors.black,
    //           fontSize: 20,
    //         ),),
    //         leading: const Icon(Icons.confirmation_number),
    //         onTap: () {
    //           context.pushNamed(AppRoutes.ticketsRoute);
    //         },
    //       ),
    //       ListTile(
    //         title: const Text('ToDo',style: TextStyle(
    //           color: Colors.black,
    //           fontSize: 20,
    //         ),),
    //         leading: const Icon(Icons.check_circle),
    //         onTap: () {
    //           context.pushNamed(AppRoutes.todoRoute);
    //         },
    //       ),
    //       ListTile(
    //         title: const Text('profile',style: TextStyle(
    //           color: Colors.black,
    //           fontSize: 20,
    //         ),),
    //         leading: const Icon(Icons.person),
    //         onTap: () {
    //           // Update the state of the app.
    //           // ...
    //         },
    //       ),
    //       ListTile(
    //         title: const Text('logout',style: TextStyle(
    //           color: Colors.black,
    //           fontSize: 20,
    //         ),),
    //         leading: const Icon(Icons.logout),
    //         onTap: () {
    //           context.pushNamedAndRemoveUntil(AppRoutes.authRoute, predicate: (route) => false );
    //         },
    //       ),
    //     ],
    //   ),
    // );
  }
}
