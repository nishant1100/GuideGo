import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guide_go/app/di/di.dart';
import 'package:guide_go/features/auth/presentation/view/profile_view.dart';
import 'package:guide_go/features/auth/presentation/view_model/useer/user_bloc.dart';
import 'package:guide_go/features/booking/presentation/user_bookings_view.dart';
import 'package:guide_go/features/booking/presentation/view_model/booking/booking_bloc.dart';
import 'package:guide_go/features/home/presentation/view/bottom_view/about_us.dart';
import 'package:guide_go/features/home/presentation/view/bottom_view/dashboard_view.dart';

class HomeState extends Equatable {
  final int selectedIndex;
  final List<Widget> views;

  const HomeState({
    required this.selectedIndex,
    required this.views,
  });

  // Initial state
  static HomeState initial() {
    return HomeState(
      selectedIndex: 0,
      views: [
        BlocProvider(
          create: (context) => getIt<BookingBloc>(),
          child: const DashboardView(),
        ),
        const UserBookingsView(),
        BlocProvider.value(
          value: getIt<UserBloc>(),
          child: const ProfileView(),
        ),
        const AboutUs(),
      ],
    );
  }

  HomeState copyWith({
    int? selectedIndex,
    List<Widget>? views,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views ?? this.views,
    );
  }

  @override
  List<Object?> get props => [selectedIndex, views];
}
