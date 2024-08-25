import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sales_crm/core/app.dart';
import 'package:sales_crm/core/constants/app_colors.dart';
import 'package:sales_crm/core/helpers/extensions.dart';
import 'package:sales_crm/core/routing/app_routes.dart';

class AuthPageBody extends StatefulWidget {
  const AuthPageBody({super.key});

  @override
  State<AuthPageBody> createState() => _AuthPageBodyState();
}

class _AuthPageBodyState extends State<AuthPageBody> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool _isPasswordVisible = false; // Step 1: Add a state variable

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  // Step 3: Add a toggle function
  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.0.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 60.0),
                Image.network('https://go-gogrow.com/wp-content/uploads/2024/04/cropped-GO-GO-GROW-05-03-1.png', height: 220),
                const SizedBox(height: 48.0),
                const Text(
                  'Login',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Login to your account',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 24.0),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Email',
                    filled: true,
                    fillColor: Colors.grey[300],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                // Step 2: Update TextField to use _isPasswordVisible
                TextFormField(
                  controller: passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    filled: true,
                    fillColor: Colors.grey[300],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    // Step 4: Change suffixIcon based on _isPasswordVisible
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Checkbox(value: false, onChanged: (bool? value) {}),
                    const Text('Remember Me'),
                    const Spacer(),
                    TextButton(
                      child: const Text('Forgot Password?', style: TextStyle(color: AppColors.primaryYellow)),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                ElevatedButton(
                  child: const Text('Sign In', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryYellow,
                    padding: EdgeInsets.symmetric(vertical: 14.0.h),
                  ),
                  onPressed: () {
                    context.pushNamed(AppRoutes.leadsRoute);
                    // if (_formKey.currentState!.validate()) {
                    //   // Step 5: Use _isPasswordVisible to get the password
                    //   final password = passwordController.text;
                    //   print('Email: ${emailController.text}');
                    //   print('Password: $password');
                    //
                    // }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

