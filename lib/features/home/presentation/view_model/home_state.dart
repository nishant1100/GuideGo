import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:guide_go/features/home/presentation/view/bottom_view/about_us.dart';
import 'package:guide_go/features/home/presentation/view/bottom_view/dashboard_view.dart';
import 'package:guide_go/features/home/presentation/view/bottom_view/placers._view.dart';
import 'package:guide_go/features/home/presentation/view/bottom_view/user_profile.dart';

class HomeState extends Equatable {
  final int selectedIndex;
  final List<Widget> views;

  const HomeState({
    required this.selectedIndex,
    required this.views,
  });

  // Initial state
  static HomeState initial() {
    return const HomeState(
      selectedIndex: 0,
      views: [
        DashboardView(),
        PlacersView(),
        UserProfile(),
        AboutUs(),
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
