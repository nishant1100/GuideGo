import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class NavigateBookingScreenEvent extends HomeEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateBookingScreenEvent({
    required this.context,
    required this.destination,
  });
}