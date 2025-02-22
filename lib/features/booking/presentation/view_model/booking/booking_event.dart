

import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object> get props => [];
}
class BookGuideEvent extends BookingEvent {
  final BuildContext context;
  final String pickupDate;
  final String pickupTime;
  final String noofPeople;
  final String? userId;
  final String pickupType;
  final String pickupLocation;

  const BookGuideEvent({
    required this.context,
    required this.pickupDate,
    required this.pickupTime,
    this.userId,
    required this.noofPeople,
    required this.pickupType,
    required this.pickupLocation,
  });
}


class UploadImageEvent extends BookingEvent{
  final BuildContext context;
  final File img;

  const UploadImageEvent({
    required this.context,
    required this.img,
  });

}






