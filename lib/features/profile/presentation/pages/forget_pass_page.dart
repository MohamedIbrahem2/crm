import 'package:crm/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/change_password_cubit.dart';
import '../widgets/custom_text_form.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  bool _isPasswordVisible = false;
  String error = '';

  Future<void> sendResetLink(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      // Trigger the password change function in the cubit
      context.read<ChangePasswordCubit>().changePassword(passwordController.text,passwordConfirmController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit(),
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      width: 900,
                      height: 550,
                      child: Form(
                        key: formKey,
                        child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
                          listener: (context, state) {
                            if (state is ChangePasswordSuccess) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.message)),
                              );
                            } else if (state is ChangePasswordFailure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.error)),
                              );
                            }
                          },
                          builder: (context, state) {
                            return Column(
                              children: [
                                const SizedBox(height: 10),
                                const Text(
                                  'Change Password',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.grey),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Enter Your New password and click change pass to change it',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                                ),
                                const SizedBox(height: 20),
                                const Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Password',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.grey),
                                  ),
                                ),
                                CustomTextForm(
                                  controller: passwordController,
                                  validate: (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'Password is empty';
                                    }
                                    if (passwordController.text.length < 8) {
                                      return 'Password must be 8 or more than 8 letter';
                                    }
                                    return null;
                                  },
                                  secure: true,
                                  obsecure: true,
                                  hint: '*******',
                                ),
                                const SizedBox(height: 15),
                                CustomTextForm(
                                  controller: passwordConfirmController,
                                  validate: (val) {
                                    if (val != passwordController.text) {
                                      return 'Password does not match';
                                    }

                                    return null;
                                  },
                                  secure: true,
                                  obsecure: true,
                                  hint: '*******',
                                ),
                                const SizedBox(height: 15),
                                ElevatedButton(
                                  onPressed: () {
                                    sendResetLink(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primaryYellow,
                                      fixedSize: const Size.fromWidth(800)),
                                  child: state is ChangePasswordLoading
                                      ? const CircularProgressIndicator()
                                      : const Text(
                                    'Change pass',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
