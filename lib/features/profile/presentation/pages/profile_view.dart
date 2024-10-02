import 'dart:io';

import 'package:crm/core/constants/app_colors.dart';
import 'package:crm/features/profile/presentation/cubit/fileUploadImage.dart';
import 'package:crm/features/profile/presentation/pages/forget_pass_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../drawer/presentation/pages/drawer_page.dart';
import '../cubit/profile_cubit.dart';

// Add the Cubit imports

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DateTime? _lastPressedAt;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Fetch profile data when the page loads
    // context.read<ProfileCubit>().fetchProfileData();
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: WillPopScope(
        onWillPop: () async {
          if (_lastPressedAt == null ||
              DateTime.now().difference(_lastPressedAt!) >
                  Duration(seconds: 2)) {
            _lastPressedAt = DateTime.now();
            // Show the Snackbar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Press back again to exit the app'),
                duration: Duration(seconds: 2),
              ),
            );
            return false; // Prevent the back navigation
          }
          return true; // Allow the back navigation (close the app)
        },
        child: Scaffold(
          drawer: const DrawerPage(),
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          body: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              print('Current state: $state');
              if (state is ProfileLoading) {
                print('Loading profile data...'); // Debug message
                return Center(child: CircularProgressIndicator());
              } else if (state is ProfileError) {
                print('Error state: ${state.message}'); // Debug message
                return Center(child: Text(state.message));
              } else if (state is ProfileLoaded) {
                final profileData = state.data;
                print('Profile loaded: $profileData');
                // Debug message
                return _buildProfileUI(profileData);
              }
              return Container(); // Default case
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProfileUI(dynamic profileData) {
    return Stack(
      children: [
        // Background image
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/yellow.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 750,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(0.0, 1.0),
                      blurRadius: 6.0,
                    ),
                  ],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
              ),
            ),
            // Profile Image and Edit Icon
            Positioned(
              top: 70,
              left: 150,
              child: SizedBox(
                width: 80,
                height: 80,
                child: Stack(
                  clipBehavior: Clip.none, // Keep or remove based on behavior
                  children: [
                    // Profile image
                    ClipOval(
                      child: Container(
                        color: Colors.white,
                        width: 80,
                        height: 80,
                        child: Image.network(
                          profileData.photoUrl ??
                              'https://example.com/default.png',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Other UI elements...
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 150),
                    const Text(
                      'Full Name',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black45,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: profileData.name ?? 'Name',
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black45,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: profileData.email ??
                            'GoGrow@gmail.com',
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            FilePickerResult? result = await FilePicker.platform.pickFiles();
                            if (result != null && result.files.isNotEmpty) {
                              File selectedFile = File(result.files.single.path!);
                              context.read<FileUploadImageCubit>().selectImageFile(selectedFile);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow),
                          child: const Text(
                            "Change Image",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (
                                context) => const ForgetPasswordPage()));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow),
                          child: const Text(
                            "Change Passowrd",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            print('Logout button pressed');
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow),
                          child: const Text(
                            "Sign Out",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

