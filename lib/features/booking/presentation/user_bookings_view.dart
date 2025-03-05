import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';
import 'package:proximity_sensor/proximity_sensor.dart';
import 'package:guide_go/app/constants/api_endpoints.dart';
import 'package:guide_go/app/di/di.dart';
import 'package:guide_go/app/shared_prefs/token_shared_prefs.dart';
import 'package:guide_go/features/booking/presentation/view_model/booking/booking_bloc.dart';
import 'package:guide_go/features/booking/presentation/view_model/booking/booking_event.dart';
import 'package:guide_go/features/booking/presentation/view_model/booking/booking_state.dart';

class UserBookingsView extends StatefulWidget {
  const UserBookingsView({super.key});

  @override
  State<UserBookingsView> createState() => _UserBookingsViewState();
}

class _UserBookingsViewState extends State<UserBookingsView> {
  late BookingBloc bookingBloc;
  StreamSubscription<dynamic>? _proximitySubscription;
  bool _isNear = false;
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    bookingBloc = getIt<BookingBloc>();
    
    // Start listening to proximity sensor
    _startProximitySensor();
    
    // Initial load of bookings
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserId(context, bookingBloc);
    });
  }

  void _startProximitySensor() {
    _proximitySubscription = ProximitySensor.events.listen((int event) {
      // When the value is 0, an object is near the sensor
      final bool isNear = event == 0;
      
      // Only trigger refresh if proximity state changes from far to near
      if (isNear && !_isNear && !_isRefreshing) {
        _isRefreshing = true;
        
        // Show a snackbar
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Refreshing page...'),
              duration: Duration(seconds: 2),
            ),
          );
        
          // Refresh the page
          _loadUserId(context, bookingBloc);
        }
        
        // Reset refresh flag after a delay
        Future.delayed(const Duration(seconds: 2), () {
          _isRefreshing = false;
        });
      }
      
      // Update the proximity state
      _isNear = isNear;
    });
  }

  @override
  void dispose() {
    // Cancel the subscription when widget is disposed
    _proximitySubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bookingBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your Bookings'),
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 0,
          backgroundColor: const Color.fromARGB(207, 155, 39, 176),
        ),
        body: BlocBuilder<BookingBloc, BookingState>(
          builder: (context, state) {
            // Show loading indicator when booking data is loading
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            // Check if bookings are successfully fetched
            if (state.isSuccess && state.booking.isNotEmpty) {
              return RefreshIndicator(
                onRefresh: () async {
                  // Trigger a refresh by reloading the userId and fetching bookings
                  await _loadUserId(context, bookingBloc);
                },
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: state.booking.length,
                  itemBuilder: (context, index) {
                    final booking = state.booking[index];
                    return _buildBookingCard(context, booking, bookingBloc);
                  },
                ),
              );
            }

            // If no bookings found
            return RefreshIndicator(
              onRefresh: () async {
                // Trigger a refresh by reloading the userId and fetching bookings
                await _loadUserId(context, bookingBloc);
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const Center(
                    child: Text(
                      'No bookings found.',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Helper method to build a booking card
  Widget _buildBookingCard(
      BuildContext context, dynamic booking, BookingBloc bookingBloc) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Place Image
          _buildImageWidget(booking.placeImage),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Guide Name
                Text(
                  'Guide: ${_getGuideName(booking.guide)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                // Pickup Date and Time
                Text(
                  'Pickup Date: ${booking.pickupDate}',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  'Pickup Time: ${booking.pickupTime}',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                // Pickup Location
                Row(
                  children: [
                    const Icon(Icons.location_on,
                        size: 16, color: Colors.blueAccent),
                    const SizedBox(width: 4),
                    Text(
                      booking.pickupLocation,
                      style: const TextStyle(
                          fontSize: 14, color: Colors.blueAccent),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Number of People
                Row(
                  children: [
                    const Icon(Icons.people, size: 16, color: Colors.green),
                    const SizedBox(width: 4),
                    Text(
                      'Number of People: ${booking.noofPeople}',
                      style: const TextStyle(fontSize: 14, color: Colors.green),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Delete Button
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      // Show confirmation dialog
                      final shouldDelete =
                          await _showDeleteConfirmationDialog(context);
                      if (shouldDelete == true) {
                        // Dispatch CancelBooking event with booking ID and context
                        bookingBloc.add(CancelBooking(
                          bookingId: booking.id, // Pass the booking ID
                          context: context, // Pass the context
                        ));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                    ),
                    child: const Text(
                      'Delete Booking',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to show a delete confirmation dialog
  Future<bool?> _showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Booking'),
        content: const Text('Are you sure you want to delete this booking?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false), // Cancel
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true), // Confirm
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  // Helper method to extract guide's name
  String _getGuideName(dynamic guide) {
    if (guide is Map<String, dynamic>) {
      // If guide is a Map, extract the name
      return guide['full_name'] ?? 'Unknown Guide';
    } else if (guide is String) {
      // If guide is a String (ID), return the ID
      return guide;
    } else {
      // Handle other cases
      return 'Unknown Guide';
    }
  }

  // Helper method to build the image widget
  Widget _buildImageWidget(String imageUrl) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      child: Image.network(
        '${ApiEndpoints.imagebaseUrl}$imageUrl', // URL of the image from the API
        height: 150,
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
            'assets/images/istockphoto-1147544807-612x612.jpg', // Replace with your fallback image path
            height: 250,
            width: double.infinity,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }

  Future<void> _loadUserId(
      BuildContext context, BookingBloc bookingBloc) async {
    final tokenPrefs = getIt<TokenSharedPrefs>();
    final result = await tokenPrefs.getUserData(); // Fetch user data

    result.fold(
      (failure) {
        print('Error fetching userId: ${failure.message}');
        // Optionally, show a snack bar or alert the user
      },
      (data) {
        final userId = data['userId']; // Extract userId
        if (userId != null) {
          // Dispatch event to fetch user bookings
          bookingBloc.add(GetUserBookingEvent(userId: userId));
        } else {
          print('UserId is empty');
          // Optionally, show a snack bar or alert the user
        }
      },
    );
  }
}