


import 'package:flutter/material.dart';

import '../widgets/auth_page_body.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: true,
      body: AuthPageBody(),
    );
  }
}
