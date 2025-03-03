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
  final String? guideId;

  const BookGuideEvent({
    required this.context,
    required this.pickupDate,
    required this.pickupTime,
    this.userId,
    this.guideId,
    required this.noofPeople,
    required this.pickupType,
    required this.pickupLocation,
  });
}

class UploadImageEvent extends BookingEvent {
  final BuildContext context;
  final File img;

  const UploadImageEvent({
    required this.context,
    required this.img,
  });
}

class OnBookSetDetails extends BookingEvent {
  final String pickupDate;
  final String pickupTime;
  final String noofPeople;
  final String pickupType;
  final String pickupLocation;
  final String selectedGuideId; // Include guide ID in the event

  const OnBookSetDetails({
    required this.pickupDate,
    required this.pickupTime,
    required this.noofPeople,
    required this.pickupType,
    required this.pickupLocation,
    required this.selectedGuideId, // Ensure the guide ID is passed here
  });
}

class GetGudiesEvent extends BookingEvent {}

class SetBookingDetailsEvent extends BookingEvent {
  final String pickupLocation;
  final String pickupDate;
  final String pickupTime;
  final String noOfPeople;
  final String pickupType;
  final bool? bookDetailset;

  const SetBookingDetailsEvent({
    required this.pickupLocation,
    required this.pickupDate,
    required this.pickupTime,
    required this.noOfPeople,
    required this.pickupType,
    this.bookDetailset,
  });
}

class SelectGuideEvent extends BookingEvent {
  final String guideId;
  final String? guidePrice;
  final String? guideName;
  final String guideImage;

  const SelectGuideEvent(
      {required this.guideId,
      required this.guideImage,
      required this.guidePrice,
      required this.guideName});
}

class UpdateBookingWithGuideEvent extends BookingEvent {
  final String guideId;
  final String bookingId;

  const UpdateBookingWithGuideEvent(
      {required this.guideId, required this.bookingId});
}

class GetUserBookingEvent extends BookingEvent {
  final String userId;

  const GetUserBookingEvent({required this.userId});
}
