import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF9C27B0), Color(0xFF2196F3)], // Gradient Colors
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              // Title Section
              Text(
                'Terms and Conditions',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),

              // Terms List Section
              _buildTermItem('1. Acceptance of Terms', 'By using the Guide Go mobile application, you agree to comply with and be bound by these Terms and Conditions. If you do not agree with any part of these terms, please do not use the app.'),
              _buildTermItem('2. User Eligibility', 'You must be at least 18 years of age to use this mobile application. By accessing and using the app, you confirm that you meet this age requirement.'),
              _buildTermItem('3. Account Registration', 'To access the services of the application, you must create an account with accurate and up-to-date information. You are responsible for maintaining the confidentiality of your login credentials and are liable for any activities under your account.'),
              _buildTermItem('4. Tour Guide Availability', 'GUide Go provides a platform for tourists to hire local guides. The availability of guides depends on location and timing. We do not guarantee the availability of a guide at any given time.'),
              _buildTermItem('5. Payment Terms', 'Tourists are required to pay the applicable fees for hiring a guide through the application. Payments must be made through the payment gateway integrated into the app. Fees are non-refundable unless specified otherwise.'),
              _buildTermItem('6. Cancellations and Refunds', 'Cancellations of guide bookings must be made at least 24 hours in advance. Refunds for cancellations will be issued based on the cancellation policy provided at the time of booking.'),
              _buildTermItem('7. Responsibility for Conduct', 'Tourists and guides are expected to maintain respectful and professional conduct during their interactions. Guide Go holds no responsibility for disputes or conflicts that arise between users.'),
              _buildTermItem('8. Limitation of Liability', 'Guide Go is not liable for any injury, loss, damage, or expenses incurred during the use of the application or while interacting with tour guides. You use the app at your own risk.'),
              _buildTermItem('9. Intellectual Property', 'All content, including but not limited to logos, text, graphics, and images, is owned by Guide Go or its licensors. You are granted a limited license to use the app for personal, non-commercial purposes.'),
              _buildTermItem('10. Changes to Terms and Conditions', 'Guide Go reserves the right to modify or update these Terms and Conditions at any time. Any changes will be communicated through the app or website, and your continued use of the app constitutes your acceptance of the modified terms.'),
              SizedBox(height: 20),

              // Button to accept the terms
              ElevatedButton(
                onPressed: () {
                  // Navigate or perform action on accept
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  'Accept Terms',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTermItem(String title, String description) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      color: Colors.white.withOpacity(0.9),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
