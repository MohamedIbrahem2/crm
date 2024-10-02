import 'package:crm/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_text_form.dart';


class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  bool isLoading = false;
  String error = '';
  Future sendResetLink() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: const []),
                    width: 900,
                    height: 550,
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: const Text(
                              'Forget Password',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          Container(
                            alignment: Alignment.center,
                            child: const Text(
                              'Enter your email address below to send you a reset password link',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              'Email',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey),
                            ),
                          ),
                          CustomTextForm(
                            controller: emailController,
                            onSave: (val) {
                              // controller.email = val!;
                            },
                            validate: (val) {
                              if (val == null) {
                                return 'email is empty';
                              }
                              return null;
                            },
                            obsecure: false,
                            hint: 'zezo@gmail.com',
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              alignment: Alignment.topRight,
                              child: const Text(
                                'Back to Login?',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                sendResetLink();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryYellow,
                                  fixedSize: Size.fromWidth(800)),
                              child: const Text('Send Reset Link',style: TextStyle(color: Colors.black),))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                      onPressed: () {

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      child: const Text('New Customer',style: TextStyle(color: Colors.white)))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
