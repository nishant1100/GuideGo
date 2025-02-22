import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guide_go/features/booking/guide_view.dart';
import 'package:guide_go/features/booking/presentation/view_model/booking/booking_bloc.dart';
import 'package:guide_go/features/booking/presentation/view_model/booking/booking_event.dart';

class BookingView extends StatefulWidget {
  const BookingView({super.key});

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController meetupPointController = TextEditingController();
  int peopleCount = 2;
  String pickupType = "On Foot";

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
                    'assets/images/heritage.jpg',
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Text(
                      "National Heritage",
                      style: TextStyle(
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
                    Text(
                      "Place: Bhaktapur Durbar Square",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    Text(
                      "Location: Bhaktapur, Nepal",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,),
                    ),


                    const SizedBox(height: 30),

                    /// Date & Time Selection - Horizontal Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Date Selection",
                              style: TextStyle(color: Colors.white, fontSize: 22),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2196F3),
                              ),
                              onPressed: () => _selectDate(context),
                              child: Text("${selectedDate.toLocal()}".split(' ')[0]),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Time Selection",
                              style: TextStyle(color: Colors.white, fontSize: 22),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2196F3),
                              ),
                              onPressed: () => _selectTime(context),
                              child: Text("${selectedTime.format(context)}"),
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
                            Text(
                              "Number of People",
                              style: TextStyle(color: Colors.white, fontSize: 22),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove, color: Colors.white),
                                  onPressed: () {
                                    setState(() {
                                      if (peopleCount > 1) peopleCount--;
                                    });
                                  },
                                ),
                                Text("$peopleCount", style: TextStyle(color: Colors.white)),
                                IconButton(
                                  icon: Icon(Icons.add, color: Colors.white),
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
                            Text(
                              "Pickup Type",
                              style: TextStyle(color: Colors.white, fontSize: 22),
                            ),
                            DropdownButton<String>(
                              value: pickupType,
                              dropdownColor: Colors.blueAccent,
                              onChanged: (String? newValue) {
                                setState(() {
                                  pickupType = newValue!;
                                });
                              },
                              items: <String>["On Foot", "By Car", "By Bike"]
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value, style: TextStyle(color: Colors.white)),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 45),

                    /// Meetup Point
                    Text(
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

                    const SizedBox(height: 105),

                    /// Hire a Guide Button
                    ElevatedButton(
                      onPressed: () {
                        context.read<BookingBloc>().add(BookGuideEvent(
                          context: context,
                          pickupDate: selectedDate.toString(),
                          pickupTime: selectedTime.toString(),
                          noofPeople: peopleCount.toString(),
                          pickupType: pickupType,
                          userId: "67b89dc6a2e9623437d7cb2f",
                          pickupLocation: meetupPointController.text,
                        ));
                        Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const GuideView()),
                    );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF9C27B0),
                        minimumSize: Size(double.infinity, 50),
                      ),
                      child: Text("Hire a Guide", style: TextStyle(color: Colors.white)),
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
