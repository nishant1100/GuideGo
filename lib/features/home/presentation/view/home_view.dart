import 'dart:math';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guide_go/core/app_theme/common/snackbar/my_snackbar.dart';
import 'package:guide_go/features/home/presentation/view_model/home_cubit.dart';
import 'package:guide_go/features/home/presentation/view_model/home_state.dart';
import 'package:sensors_plus/sensors_plus.dart'; // For accelerometer events

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // Listen for shake detection on widget initialization
    _listenToShake(context);

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF9C27B0),
          ),
        ),
        title: const Text(
          'GUIDE GO',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: () {
              showMySnackBar(
                context: context,
                message: 'Logging Out.',
                color: Colors.red,
              );
              context.read<HomeCubit>().logout(context);
            },
          ),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: state.views.elementAt(state.selectedIndex),
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return CurvedNavigationBar(
            backgroundColor: Colors.white,
            color: Colors.blueAccent,
            buttonBackgroundColor: Colors.white,
            height: 60,
            animationDuration: const Duration(milliseconds: 300),
            index: state.selectedIndex,
            items: const [
              Icon(Icons.home, size: 30, color: Colors.black),
              Icon(Icons.bookmark_add, size: 30, color: Colors.black),
              Icon(Icons.person, size: 30, color: Colors.black),
              Icon(Icons.diversity_3, size: 30, color: Colors.black),
            ],
            onTap: (index) {
              context.read<HomeCubit>().onTabTapped(index);
            },
          );
        },
      ),
    );
  }

  // Method to listen to shake events and log out on shake
  void _listenToShake(BuildContext context) {
    bool isCurrentlyShaking = false;
    DateTime? lastShakeTime;
    const double shakeThreshold =
        11; // Adjusted threshold for shake sensitivity
    const int cooldownPeriod = 2; // Cooldown period in seconds

    accelerometerEvents.listen((AccelerometerEvent event) {
      final now = DateTime.now();

      // Print sensor values for debugging
      print(
          'Accelerometer Event - X: ${event.x}, Y: ${event.y}, Z: ${event.z}');

      // Calculate total acceleration magnitude
      final acceleration =
          sqrt(event.x * event.x + event.y * event.y + event.z * event.z);
      print('Acceleration Magnitude: $acceleration');

      // Check cooldown period
      if (lastShakeTime != null &&
          now.difference(lastShakeTime!).inSeconds < cooldownPeriod) {
        print('Cooldown period active. Ignoring shake.');
        return;
      }

      // Detect shake if acceleration exceeds the threshold
      if (acceleration > shakeThreshold && !isCurrentlyShaking) {
        print('Shake detected! Logging out...');

        // Set shake state to prevent multiple triggers
        isCurrentlyShaking = true;
        lastShakeTime = now;

        // Show a snackbar to indicate logout
        showMySnackBar(
          context: context,
          message: 'Logging out...',
          color: Colors.red,
        );

        // Trigger the logout action
        context.read<HomeCubit>().logout(context);

        // Reset shake state after cooldown
        Future.delayed(const Duration(seconds: cooldownPeriod), () {
          isCurrentlyShaking = false;
          print('Shake detection reset.');
        });
      }
    });
  }
}
