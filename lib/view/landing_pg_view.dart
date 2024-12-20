import 'package:flutter/material.dart';
import 'package:guide_go/view/login_screen_view.dart';

class LandingPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> onboardingData = [
      {
        'imagePath': 'assets/logo/guide_go.png',
        'title': 'Experience the Unseen',
        'description':
            'Embark on unforgettable adventures and discover hidden gems. Nepal awaits you!',
        'gradientColors': [Color(0xFF7B1FA2), Color(0xFF536DFE)], 
      },
      {
        'imagePath': 'assets/logo/guide_go.png',
        'title': 'Thrilling Adventures',
        'description':
            'From trekking in the Himalayas to rafting in wild rivers, adventure awaits!',
        'gradientColors': [Color(0xFF536DFE), Color(0xFF7B1FA2)],
      },
      {
        'imagePath': 'assets/logo/guide_go.png',
        'title': 'Discover the Culture',
        'description':
            'Immerse yourself in Nepal’s rich heritage, festivals, and traditions.',
        'gradientColors': [Color(0xFF7B1FA2), Color(0xFF536DFE)], 
        'isLastPage': true,
      },
    ];

    return Scaffold(
      body: PageView.builder(
        itemCount: onboardingData.length,
        itemBuilder: (context, index) {
          final data = onboardingData[index];
          return OnboardingPage(
            imagePath: data['imagePath'],
            title: data['title'],
            description: data['description'],
            gradientColors: data['gradientColors'],
            isLastPage: data['isLastPage'] ?? false,
          );
        },
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final List<Color> gradientColors;
  final bool isLastPage;

  const OnboardingPage({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.gradientColors,
    this.isLastPage = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Image.asset(
            imagePath,
            height: MediaQuery.of(context).size.height * 0.4,
            semanticLabel: title,
          ),
          SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
          ),
          Spacer(),
          if (isLastPage)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the LoginScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginView()),
                  );
                },
                // style: ElevatedButton.styleFrom(
                //   backgroundColor: const Color(0xFF9C27B0),
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(30),
                //   ),
                //   padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                // ),
                child: Text(
                  'Hire Your Guide',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}

