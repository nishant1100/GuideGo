import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guide_go/app/di/di.dart';
import 'package:guide_go/app/shared_prefs/token_shared_prefs.dart';
import 'package:guide_go/features/booking/presentation/view_model/booking/booking_bloc.dart';
import 'package:guide_go/features/booking/presentation/view_model/booking/booking_event.dart';
import 'package:guide_go/features/booking/presentation/view_model/booking/booking_state.dart';

class UserBookingsView extends StatelessWidget {
  const UserBookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the bookingBloc and load userId
    final _bookingBloc = getIt<BookingBloc>();

    // Load the userId during the widget's build phase
    _loadUserId(context, _bookingBloc);

    return BlocProvider(
      create: (context) => _bookingBloc,
      child: Scaffold(
        appBar: AppBar(title: Text('Your Bookings')),
        body: BlocBuilder<BookingBloc, BookingState>(
          builder: (context, state) {
            // Show loading indicator when booking data is loading
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            // Check if bookings are successfully fetched
            if (state.isSuccess && state.booking.isNotEmpty) {
              return ListView.builder(
                itemCount: state.booking.length,
                itemBuilder: (context, index) {
                  final booking = state.booking[index];
                  return ListTile(
                    title: Text('Booking for ${_getGuideName(booking.guide)}'), // Access guide's name
                    subtitle: Text(
                      'Pickup Date: ${booking.pickupDate}\nPickup Location: ${booking.pickupLocation}',
                    ),
                  );
                },
              );
            }

            // If no bookings found
            return const Center(child: Text('No bookings found.'));
          },
        ),
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

  Future<void> _loadUserId(BuildContext context, BookingBloc bookingBloc) async {
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