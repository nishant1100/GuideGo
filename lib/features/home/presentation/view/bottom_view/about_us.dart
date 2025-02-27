import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [const Color(0xFF9C27B0), const Color(0xFF2196F3)],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your Trusted Guide Hiring Platform",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: const Color(0xFFFFFFFF),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 90,
                    height: 130,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/logo/guide_go.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 0),
              _buildCard(
                title: "About Us",
                content:
                    "Established in 2024, we are dedicated to providing the best tour guides for travelers across Nepal. Our platform connects tourists with professional guides, ensuring a seamless and enriching travel experience.",
              ),
              _buildCard(
                title: "Why Choose Us?",
                content:
                    "✓ 98% Successful Tour Rate\n✓ Trusted by 10,000+ Travelers\n✓ Partnered with Top Travel Agencies\n✓ Awarded Best Tourism Service 2025",
              ),
              _buildCard(
                title: "Contact Us",
                content:
                    "📍 Kathmandu, Nepal\n📞 +977 9800000000\n✉️ support@guidego.com",
              ),
              SizedBox(height: 10),
              _buildSocialIcons(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required String title, required String content}) {
    return Card(
      color: Colors.white.withOpacity(0.9), // Soft opacity background
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              content,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _socialIcon(FontAwesomeIcons.facebook, Colors.black),
        _socialIcon(FontAwesomeIcons.instagram, Colors.pink),
        _socialIcon(FontAwesomeIcons.twitter, Colors.lightBlue),
        _socialIcon(FontAwesomeIcons.tiktok, Colors.black),
      ],
    );
  }

  Widget _socialIcon(IconData icon, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: IconButton(
        icon: FaIcon(icon, color: color),
        onPressed: () {},
      ),
    );
  }
}
