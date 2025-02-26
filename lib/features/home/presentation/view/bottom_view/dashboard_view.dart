import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  @override
  Widget build(BuildContext context) {
    return Container(
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
                      image: 'assets/images/heritage.jpg',
                      title: 'National Heritage',
                      places: ['Bhaktapur', 'Patan Durbar Square', 'Lumbini'],
                    ),
                    PlaceCard(
                      image: 'assets/images/thrill.jpg',
                      title: 'Feel the thrill',
                      places: ['Pokhara', 'Annapurna Circuit', 'Chitwan'],
                    ),
                    PlaceCard(
                        image: 'assets/images/wildlife.jpg',
                        title: 'Wildlife and Nature',
                        places: [
                          'Chitwan National Park',
                          'Bardia National Park',
                          'Shivapuri'
                        ]),
                    PlaceCard(
                        image: 'assets/images/trek.jpg',
                        title: 'Trekking Adventures',
                        places: [
                          'Everest Base Camp',
                          'Annapurna Base Camp',
                          'Langtang'
                        ]),
                    PlaceCard(
                        image: 'assets/images/spiritual.jpg',
                        title: 'Spiritual Retreats',
                        places: [
                          'Pashupatinath Temple',
                          'Muktinath',
                          'Lumbini'
                        ]),
                    PlaceCard(
                        image: 'assets/images/homestay.jpeg',
                        title: 'Village Stay',
                        places: ['Ghandruk', 'Bandipur', 'Tansen']),
                  ],
                ),
              ),
            ],
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
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            image,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
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
                              places:places
                            ),
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
