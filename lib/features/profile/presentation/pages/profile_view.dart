import 'dart:io';
import 'package:crm/core/constants/app_colors.dart';
import 'package:crm/features/leads/presentation/pages/leads_page.dart';
import 'package:crm/features/profile/data/model/profile%20model.dart';
import 'package:crm/features/profile/presentation/cubit/fileUploadImage.dart';
import 'package:crm/features/profile/presentation/pages/forget_pass_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../drawer/presentation/pages/drawer_page.dart';
import '../cubit/profile_cubit.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final screenSize = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: WillPopScope(
        onWillPop: () async {
          if (_lastPressedAt == null ||
              DateTime.now().difference(_lastPressedAt!) >
                  Duration(seconds: 2)) {
            _lastPressedAt = DateTime.now();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Press back again to exit the app'),
                duration: Duration(seconds: 2),
              ),
            );
            return false;
          }
          return true;
        },
        child: Scaffold(
          drawer: const DrawerPage(),
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          body: BlocBuilder<ProfileCubit, ProfileState>(
            bloc: context.read<ProfileCubit>()..fetchProfileData(),
            builder: (context, state) {
              if (state is ProfileLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ProfileError) {
                return Center(child: Text(state.message));
              } else if (state is ProfileLoaded) {
                final profileData = state.data;
                return _buildProfileUI(profileData, screenSize);
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProfileUI(dynamic profileData, Size screenSize) {
    return Stack(
      children: [
        // Background image
        Container(
          width: screenSize.width,
          height: screenSize.height,
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
                height: screenSize.height * 0.75, // Responsive height
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
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                return Positioned(
                  top: screenSize.height * 0.1,
                  // Adjust for different screen heights
                  left: screenSize.width * 0.3,
                  // Center based on screen width
                  child: SizedBox(
                    width: screenSize.width * 0.4,
                    // Adjust size relative to screen
                    height: screenSize.width * 0.4,
                    child: Stack(
                      children: [
                        // Profile image
                        ClipOval(
                          child: Container(
                            color: Colors.white,
                            child: profileData.photoUrl != null
                                ? Image.network(
                                    profileData.photoUrl,
                                    width: screenSize.width * 0.4,
                                    height: screenSize.width * 0.4,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset("assets/images/logo.png"),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(height: screenSize.height * 0.25),
                    // Adjust based on screen height
                    _buildProfileField('Full Name', profileData.name ?? 'Name'),
                    SizedBox(height: screenSize.height * 0.02),
                    _buildProfileField(
                        'Email', profileData.email ?? 'GoGrow@gmail.com'),
                    SizedBox(height: screenSize.height * 0.03),
                    _buildButton('Change Image', () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();
                      if (result != null && result.files.isNotEmpty) {
                        File selectedFile = File(result.files.single.path!);
                        context
                            .read<FileUploadImageCubit>()
                            .selectImageFile(selectedFile);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LeadsPage()));
                      }
                    }),
                    SizedBox(height: screenSize.height * 0.02),
                    _buildButton('Change Password', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ForgetPasswordPage()));
                    }),
                    SizedBox(height: screenSize.height * 0.02),
                    _buildButton('Sign Out', () {
                      print('Logout button pressed');
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black45,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          readOnly: true,
          decoration: InputDecoration(
            labelText: value,
          ),
        ),
      ],
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 60,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
