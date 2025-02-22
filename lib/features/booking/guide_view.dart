import 'package:flutter/material.dart';
import 'package:guide_go/features/booking/conformation_view.dart';

class GuideView extends StatelessWidget {
  const GuideView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> guides = [
      {"name": "Geeta", "image": "assets/images/guide1.jpeg", "rating": 4.4},
      {"name": "Hari", "image": "assets/images/guide2.jpeg", "rating": 4.3},
      {"name": "Suraj", "image": "assets/images/guide3.jpeg", "rating": 4.2},
      {"name": "Deepak", "image": "assets/images/guide4.jpeg", "rating": 4.1},
      {"name": "Nitu", "image": "assets/images/guide5.jpeg", "rating": 4.0},
      {"name": "Geeta", "image": "assets/images/guide6.jpeg", "rating": 3.6},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Guides"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF9C27B0), Color(0xFF2196F3)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            itemCount: guides.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              final guide = guides[index];
              return GuideCard(
                name: guide["name"],
                image: guide["image"],
                rating: guide["rating"],
                onBookNow: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfirmationView(
                        guideName: guide["name"],
                        guideImage: guide["image"],
                        experience: "Exploring cultural heritage & local sites",
                        selectedDate: DateTime.now(),
                        selectedTime: TimeOfDay.now(),
                        meetupPoint: "Thamel, Kathmandu",
                        pickupType: "Hotel Pickup",
                        totalAmount: 55.0,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class GuideCard extends StatelessWidget {
  final String name;
  final String image;
  final double rating;
  final VoidCallback onBookNow;

  const GuideCard({
    required this.name,
    required this.image,
    required this.rating,
    required this.onBookNow,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(0.2),
      ),
      child: Column(
        children: [
          const SizedBox(height: 8),
          CircleAvatar(
            radius: 45,
            backgroundImage: AssetImage(image),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),

          // Star Rating Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              double starValue = index + 1;
              return Icon(
                rating >= starValue
                    ? Icons.star
                    : rating >= starValue - 0.5
                        ? Icons.star_half
                        : Icons.star_border,
                color: Colors.orange,
                size: 18,
              );
            }),
          ),

          const SizedBox(height: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF9C27B0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: onBookNow,
            child: const Text("Book Now"),
          ),
        ],
      ),
    );
  }
}
