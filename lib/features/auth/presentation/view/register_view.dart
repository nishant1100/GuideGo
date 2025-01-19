import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'terms_and_conditions.dart'; // Create a separate page for Terms and Conditions
import 'login_view.dart'; // Make sure to create this page for login

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _gap = const SizedBox(height: 16);
  final _key = GlobalKey<FormState>();
  final _fnameController = TextEditingController(text: '');
  final _lnameController = TextEditingController(text: '');
  final _phoneController = TextEditingController(text: '');
  final _usernameController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');
  bool _termsAccepted = false;

  @override
  void initState() {
    super.initState();
    Hive.openBox('users'); // Open Hive box for users
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background with Linear Gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color(0xFFF13E3E), const Color(0xFF1434E9)],
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
                  const SizedBox(height: 0),

                  // Logo Section
                  Image.asset(
                    'assets/logo/guide_go.png', // Add your logo path here
                    width: 200,
                    height: 180,
                    fit: BoxFit.contain,
                  ),

                  const Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 0),
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        children: [
                          TextSpan(text: "To\n"),
                          TextSpan(text: "embark adventures & discover hidden gems"),
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
                              controller: _fnameController,
                              labelText: 'First Name',
                              icon: Icons.person,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter first name';
                                }
                                return null;
                              },
                            ),
                            _gap,
                            buildTextField(
                              controller: _lnameController,
                              labelText: 'Last Name',
                              icon: Icons.person_outline,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter last name';
                                }
                                return null;
                              },
                            ),
                            _gap,
                            buildTextField(
                              controller: _phoneController,
                              labelText: 'Phone Number',
                              icon: Icons.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter phone number';
                                }
                                return null;
                              },
                            ),
                            _gap,
                            buildTextField(
                              controller: _usernameController,
                              labelText: 'Username',
                              icon: Icons.account_circle,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter username';
                                }
                                return null;
                              },
                            ),
                            _gap,
                            buildTextField(
                              controller: _passwordController,
                              labelText: 'Password',
                              icon: Icons.lock,
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter password';
                                }
                                return null;
                              },
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
                                      // Navigate to Terms and Conditions page
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const TermsAndConditionsPage(),
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
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () async {
                                if (_key.currentState!.validate()) {
                                  if (!_termsAccepted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('You must accept the Terms and Conditions to register!'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                    return;
                                  }

                                  final box = Hive.box('users');

                                  if (box.containsKey(_usernameController.text)) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Username already exists!'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                    return;
                                  }

                                  await box.put(
                                    _usernameController.text,
                                    {
                                      'firstName': _fnameController.text,
                                      'lastName': _lnameController.text,
                                      'phone': _phoneController.text,
                                      'password': _passwordController.text,
                                    },
                                  );

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Registration successful! Please log in.'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                  Navigator.pushNamed(context, '/login'); // Navigate to login screen
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
                            // Sign In TextButton
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
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
        ),
      ),
      style: const TextStyle(color: Colors.black),
      validator: validator,
    );
  }
}
