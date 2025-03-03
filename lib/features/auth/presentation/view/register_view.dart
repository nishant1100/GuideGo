import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guide_go/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:guide_go/features/auth/presentation/view_model/signup/register_event.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'login_view.dart';
import 'terms_and_conditions.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _gap = const SizedBox(height: 16);
  final _key = GlobalKey<FormState>();
  final _fullnameController = TextEditingController(text: '');
  final _phoneController = TextEditingController(text: '');
  final _usernameController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');
  bool _termsAccepted = false;
  File? _image;

  @override
  void initState() {
    super.initState();
    Hive.openBox('users'); // Open Hive box for users
  }

checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.isDenied) {
      await Permission.camera.request();
    }
  }

  File? _img;
  String? imagePath;

  Future _browseImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          imagePath = image.path.split('/').last;
          print("path set $imagePath");
          _img = File(image.path);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _handleImageSelection(
      BuildContext innercontext, ImageSource source) async {
    await _browseImage(source);
    print("Selected image: $_img");
    if (_img != null) {
      context.read<RegisterBloc>().add(
            UploadImageEvent(context: context, img: _img!),
          );
    }
    Navigator.pop(innercontext);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFF13E3E), Color(0xFF1434E9)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          backgroundColor: Colors.grey[300],
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          builder: (innercontext) => Padding(
                            padding: const EdgeInsets.all(20),
                            child: SizedBox(
                              width: double.infinity, // Constrain the width
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize:
                                    MainAxisSize.min, // Prevent infinite width
                                children: [
                                  Flexible(
                                    // Add Flexible to buttons
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        checkCameraPermission();
                                        _handleImageSelection(
                                            context, ImageSource.camera);
                                      },
                                      icon: const Icon(Icons.camera),
                                      label: const Text('Camera'),
                                    ),
                                  ),
                                  Flexible(
                                    // Add Flexible to buttons
                                    child: ElevatedButton.icon(
                                      onPressed: () {
                                        checkCameraPermission();
                                        _handleImageSelection(
                                            context, ImageSource.gallery);
                                      },
                                      icon: const Icon(Icons.image),
                                      label: const Text('Gallery'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      child: SizedBox(
                        width: 145, // Fixed width
                        height: 145, // Fixed height
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 55,
                          backgroundImage: _img != null
                              ? FileImage(_img!)
                              : const AssetImage(
                                      'assets/logo/user.png')
                                  as ImageProvider,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(text: "To\n"),
                          TextSpan(
                              text: "embark adventures & discover hidden gems"),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _key,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            buildTextField(
                              controller: _fullnameController,
                              labelText: 'First Name',
                              icon: Icons.person,
                              validator: (value) => value!.isEmpty
                                  ? 'Please enter first name'
                                  : null,
                            ),
                            _gap,
                            buildTextField(
                              controller: _phoneController,
                              labelText: 'Phone Number',
                              icon: Icons.phone,
                              validator: (value) => value!.isEmpty
                                  ? 'Please enter phone number'
                                  : null,
                            ),
                            _gap,
                            buildTextField(
                              controller: _usernameController,
                              labelText: 'Username',
                              icon: Icons.account_circle,
                              validator: (value) => value!.isEmpty
                                  ? 'Please enter username'
                                  : null,
                            ),
                            _gap,
                            buildTextField(
                              controller: _passwordController,
                              labelText: 'Password',
                              icon: Icons.lock,
                              obscureText: true,
                              validator: (value) => value!.isEmpty
                                  ? 'Please enter password'
                                  : null,
                            ),
                            _gap,
                            Row(
                              children: [
                                Checkbox(
                                  value: _termsAccepted,
                                  onChanged: (value) {
                                    setState(() {
                                      _termsAccepted = value ?? false;
                                    });
                                  },
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const TermsAndConditionsPage(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "I agree to the Terms and Conditions",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0x9DEB3838),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () async {
                                if (_key.currentState!.validate()) {
                                  final RegisterState = 
                                      context.read<RegisterBloc>().state;
                                  final imageName = RegisterState.imageName;
                                  // if (imagePath == null) {  
                                  //   ScaffoldMessenger.of(context).showSnackBar(
                                  //     const SnackBar(content: Text("Please select an image")),
                                  //   );
                                  //   return;
                                  // }
                                
                                context.read<RegisterBloc>().add(RegisterUser(
                                  context: context,
                                  full_Name: _fullnameController.text,
                                  username: _usernameController.text,
                                  image: imagePath?? '',
                                  phone: _phoneController.text,
                                  password: _passwordController.text,
                                  ));
                                }
                              },
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/login');
                              },
                              child: const Text(
                                'Already have an account? Sign In',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
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
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    String? Function(String?)? validator,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color(0xFF013D59)),
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Color(0xFFABBCC6),
          fontWeight: FontWeight.bold,
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.black),
      validator: validator,
    );
  }
}
