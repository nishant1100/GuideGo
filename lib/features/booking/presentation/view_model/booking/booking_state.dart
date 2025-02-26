import 'package:equatable/equatable.dart';
import 'package:guide_go/features/booking/domain/entity/book_guide_entity.dart';
import 'package:guide_go/features/booking/domain/entity/guide_entity.dart';

class BookingState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String pickupDate;
  final String pickupTime;
  final String noofPeople;
  final String pickupType;
  final String pickupLocation;
  final bool bookDetailset;
  final String? bookingId;
  final BookGuideEntity booking;

  final String? guideId;
  final String? guidePrice;
  final String? guideName;
  final String? guideImage;
  final List<GuideEntity>? guides;

  const BookingState({
    required this.isLoading,
    required this.isSuccess,
    required this.pickupDate,
    required this.pickupTime,
    this.bookingId,
    required this.booking,
    required this.noofPeople,
    required this.bookDetailset,
    this.guideId,
    this.guideImage,
    this.guideName,
    this.guidePrice,
    required this.pickupType,
    this.guides,
    required this.pickupLocation,
  });

  const BookingState.initial()
      : isLoading = false,
        bookDetailset = false,
        isSuccess = false,
        guideId = '',
        guideImage = '',
        guideName = '',
        guidePrice = '',
        booking = const BookGuideEntity.initial(),
        pickupDate = '',
        pickupTime = '',
        bookingId = '',
        noofPeople = '',
        pickupType = '',
        guides = const [],
        pickupLocation = '';

  BookingState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? guideId,
    String? guidePrice,
    String? guideName,
    String? guideImage,
    String? pickupDate,
    String? pickupTime,
    bool? bookDetailset,
    BookGuideEntity? booking,
    String? bookingId,
    String? noofPeople,
    List<GuideEntity>? guides,
    String? pickupType,
    String? pickupLocation,
  }) {
    return BookingState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      guideId: guideId ?? this.guideId,
      bookDetailset: bookDetailset ?? this.bookDetailset,
      pickupDate: pickupDate ?? this.pickupDate,
      guides: guides ?? this.guides,
      pickupTime: pickupTime ?? this.pickupTime,
      guideImage: guideImage ?? this.guideImage,
      booking: booking??this.booking,
      bookingId: bookingId ?? this.bookingId,
      guideName: guideName ?? this.guideName,
      guidePrice: guidePrice ?? this.guidePrice,
      noofPeople: noofPeople ?? this.noofPeople,
      pickupType: pickupType ?? this.pickupType,
      pickupLocation: pickupLocation ?? this.pickupLocation,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        pickupDate,
        pickupTime,
        guideId,
        bookingId,
        guideImage,
        guideName,
        booking,
        guidePrice,
        guides,
        noofPeople,
        pickupType,
        pickupLocation,
        bookDetailset,
      ];
}
