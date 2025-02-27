import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  // Controllers for form fields
  final TextEditingController _fullNameController = TextEditingController(text: "Nishant Shrestha");
  final TextEditingController _usernameController = TextEditingController(text: "@nishantshrestha");
  final TextEditingController _phoneController = TextEditingController(text: "9841234567");
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF9C27B0), Color(0xFF2196F3)], // Gradient Colors
          ),
        ),
        child: SingleChildScrollView( // Add scroll functionality for better UI on smaller screens
          child: Column(
            children: [
              SizedBox(height: 40), // Adjust for AppBar removal
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/profile/user.png'), // Replace with your profile image path
                ),
              ),
              SizedBox(height: 15),
              Text(
                "Edit Profile", // Updated text for the page
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 30),
              _buildTextField("Full Name", _fullNameController),
              SizedBox(height: 12),
              _buildTextField("Username", _usernameController),
              SizedBox(height: 12),
              _buildTextField("Phone Number", _phoneController),
              SizedBox(height: 12),
              _buildTextField("Change Password", _passwordController, obscureText: true),
              SizedBox(height: 50),
              _buildSaveButton(),
              SizedBox(height: 200),
            ],
          ),
        ),
      ),
    );
  }

  // Function to build text fields
  Widget _buildTextField(String label, TextEditingController controller, {bool obscureText = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: const Color.fromARGB(255, 0, 0, 0),fontSize: 20),
          filled: true,
          fillColor: Colors.white.withOpacity(0.8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // Function to build save button
  Widget _buildSaveButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            // Handle save profile changes
            print("Profile Updated");
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF9C27B0),
            foregroundColor: const Color.fromARGB(255, 255, 255, 255),
            padding: EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Text(
            "Save Changes",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
