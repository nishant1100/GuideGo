import 'dart:io'; // Import for InternetAddress

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guide_go/app/constants/api_endpoints.dart';
import 'package:guide_go/app/di/di.dart';
import 'package:guide_go/features/booking/booking_view.dart';
import 'package:guide_go/features/booking/presentation/view_model/booking/booking_bloc.dart';
import 'package:guide_go/features/booking/presentation/view_model/booking/booking_event.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  // A method to handle refreshing (reload the page)
  Future<void> _refreshPage() async {
    // Add your logic here to refresh the data, like fetching updated content
    // For example, triggering the BookingBloc event to fetch the latest data
    context.read<BookingBloc>().add(GetGudiesEvent());
    await Future.delayed(const Duration(seconds: 2)); // Simulate loading time
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshPage, // This method will be triggered on drag-down
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF9C27B0), Color(0xFF2196F3)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 0),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [],
                          ),
                        ],
                      ),
                      const SizedBox(height: 0),
                      TextField(
                        decoration: InputDecoration(
                          hintText: "Start searching here...",
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon:
                              const Icon(Icons.search, color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        "Discover Places",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CategoryChip(label: "All", isSelected: true),
                          CategoryChip(label: "Restaurants"),
                          CategoryChip(label: "Parks"),
                          CategoryChip(label: "Entertainment"),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: const [
                      PlaceCard(
                        image: 'heritage.jpg',
                        title: 'National Heritage',
                        places: ['Bhaktapur', 'Patan Durbar Square', 'Lumbini'],
                      ),
                      PlaceCard(
                        image: 'thrill.jpg',
                        title: 'Feel the thrill',
                        places: ['Pokhara', 'Annapurna Circuit', 'Chitwan'],
                      ),
                      PlaceCard(
                          image: 'wildlife.jpg',
                          title: 'Wildlife and Nature',
                          places: [
                            'Chitwan National Park',
                            'Bardia National Park',
                            'Shivapuri'
                          ]),
                      PlaceCard(
                          image: 'trek.jpg',
                          title: 'Trekking Adventures',
                          places: [
                            'Everest Base Camp',
                            'Annapurna Base Camp',
                            'Langtang'
                          ]),
                      PlaceCard(
                          image: 'spiritual.jpg',
                          title: 'Spiritual Retreats',
                          places: [
                            'Pashupatinath Temple',
                            'Muktinath',
                            'Lumbini'
                          ]),
                      PlaceCard(
                          image: 'homestay.jpeg',
                          title: 'Village Stay',
                          places: ['Ghandruk', 'Bandipur', 'Tansen']),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const CategoryChip({
    super.key,
    required this.label,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.orange : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// Helper method to build the image widget
Widget _buildImageWidget(String imageUrl) {
  return FutureBuilder(
    future: _checkInternetConnection(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        // While checking connectivity, show a loading indicator
        return Container(
          height: 250,
          width: double.infinity,
          color: Colors.grey[300],
          child: const Center(child: CircularProgressIndicator()),
        );
      } else if (snapshot.hasData && snapshot.data == true) {
        // If connected to the internet, show the image from the network
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            '${ApiEndpoints.imagebaseUrl}$imageUrl', // URL of the image from the API
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child; // Image loaded successfully
              }
              // Show a loading placeholder while the image is being fetched
              return Container(
                height: 250,
                width: double.infinity,
                color: Colors.grey[300],
                child: const Center(child: CircularProgressIndicator()),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              // Show a fallback image if the image fails to load
              return Image.asset(
                'assets/images/istockphoto-1147544807-612x612.jpg', // Fallback image path
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              );
            },
          ),
        );
      } else {
        // If not connected to the internet, show the fallback image
        return Image.asset(
          'assets/images/istockphoto-1147544807-612x612.jpg', // Fallback image path
          height: 250,
          width: double.infinity,
          fit: BoxFit.cover,
        );
      }
    },
  );
}

// Function to check internet connection
Future<bool> _checkInternetConnection() async {
  final connectivityResults = await Connectivity().checkConnectivity();
  final ConnectivityResult result = connectivityResults.isNotEmpty
      ? connectivityResults.first
      : ConnectivityResult.none;
  if (result == ConnectivityResult.none) {
    return false; // No internet connection
  } else {
    try {
      final response = await InternetAddress.lookup('google.com');
      return response.isNotEmpty && response[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false; // If no connection to Google is available
    }
  }
}

class PlaceCard extends StatelessWidget {
  final String image;
  final String title;
  final List<String> places;

  const PlaceCard({
    super.key,
    required this.image,
    required this.places,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildImageWidget(image),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                            value: getIt<BookingBloc>()..add(GetGudiesEvent()),
                            child: BookingView(
                                image: image, // Pass the image variable
                                title: title,
                                places: places),
                          ),
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Book Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
