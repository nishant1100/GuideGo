import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guide_go/app/di/di.dart';
import 'package:guide_go/features/booking/conformation_view.dart';
import 'package:guide_go/features/booking/presentation/view_model/booking/booking_bloc.dart';
import 'package:guide_go/features/booking/presentation/view_model/booking/booking_event.dart';
import 'package:guide_go/features/booking/presentation/view_model/booking/booking_state.dart';

class BookingView extends StatefulWidget {
  final String image;
  final String title;
  final List<String> places;

  const BookingView(
      {super.key,
      required this.image,
      required this.title,
      required this.places});

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController meetupPointController = TextEditingController();
  int peopleCount = 2;
  String pickupType = "On Foot";
  String? selectedGuideId; // To store the selected guide's ID
  String guideName = '';
  String guidePrice = '';
  String guideImage = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF9C27B0), Color(0xFF2196F3)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(
                    widget.image,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    ...widget.places.map(
                      (e) => Text(
                        e,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ),

                    const Text(
                      "Location: Bhaktapur, Nepal",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// Date & Time Selection - Horizontal Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Date Selection",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2196F3),
                              ),
                              onPressed: () => _selectDate(context),
                              child: Text(
                                  "${selectedDate.toLocal()}".split(' ')[0]),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Time Selection",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2196F3),
                              ),
                              onPressed: () => _selectTime(context),
                              child: Text(selectedTime.format(context)),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 45),

                    /// Number of People & Pickup Type - Horizontal Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Number of People",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove,
                                      color: Colors.white),
                                  onPressed: () {
                                    setState(() {
                                      if (peopleCount > 1) peopleCount--;
                                    });
                                  },
                                ),
                                Text("$peopleCount",
                                    style:
                                        const TextStyle(color: Colors.white)),
                                IconButton(
                                  icon: const Icon(Icons.add,
                                      color: Colors.white),
                                  onPressed: () {
                                    setState(() {
                                      peopleCount++;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Pickup Type",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 22),
                            ),
                            DropdownButton<String>(
                              value: pickupType,
                              dropdownColor: Colors.blueAccent,
                              onChanged: (String? newValue) {
                                setState(() {
                                  pickupType = newValue!;
                                });
                              },
                              items: <String>[
                                "On Foot",
                                "By Car",
                                "By Bike"
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,
                                      style:
                                          const TextStyle(color: Colors.white)),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 45),

                    /// Meetup Point
                    const Text(
                      "Meetup Point",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    TextField(
                      controller: meetupPointController,
                      decoration: InputDecoration(
                        hintText: "Enter Your Pickup Location",
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// Guide Selection
                    const Text(
                      "Select a Guide",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    const SizedBox(height: 10),
                    BlocProvider(
                      create: (_) =>
                          getIt<BookingBloc>()..add(GetGudiesEvent()),
                      child: BlocBuilder<BookingBloc, BookingState>(
                        builder: (context, state) {
                          if (state.isLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state.isSuccess && state.guides != null) {
                            final guides = state.guides!;
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: guides.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 0.8,
                              ),
                              itemBuilder: (context, index) {
                                final guide = guides[index];
                                return GuideCard(
                                  name: guide.full_name,
                                  image: guide.image,
                                  rating: 2.3,
                                  onBookNow: () {
                                    setState(() {
                                      selectedGuideId = guide.guideId;
                                      guideName = guide.full_name;
                                      guidePrice = guide.price;
                                      guideImage = guide.image;
                                    });
                                  },
                                );
                              },
                            );
                          } else if (!state.isSuccess) {
                            return const Center(
                                child: Text('Failed to load guides.'));
                          }
                          return const Center(child: Text('Unknown State'));
                        },
                      ),
                    ),

                    const SizedBox(height: 30),

                    /// Hire a Guide Button
                    ElevatedButton(
                      onPressed: () {
                        if (selectedGuideId == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Please select a guide.")),
                          );
                          return;
                        }

                        context.read<BookingBloc>().add(BookGuideEvent(
                              context: context,
                              pickupDate: selectedDate.toString(),
                              pickupTime: selectedTime.toString(),
                              noofPeople: peopleCount.toString(),
                              pickupType: pickupType,
                              userId: "67b89dc6a2e9623437d7cb2f",
                              guideId: selectedGuideId!,
                              pickupLocation: meetupPointController.text,
                            ));

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ConfirmationView(
                                    guideName: guideName,
                                    guideImage: guideImage,
                                    selectedDate: selectedDate,
                                    selectedTime: selectedTime,
                                    meetupPoint: meetupPointController.text,
                                    pickupType: pickupType,
                                    totalAmount: double.parse(guidePrice))));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF9C27B0),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text("Hire a Guide",
                          style: TextStyle(color: Colors.white)),
                    ),
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
          const SizedBox(height: 4), // Star Rating Row
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
            child: const Text("Select Guide"),
          ),
        ],
      ),
    );
  }
}
