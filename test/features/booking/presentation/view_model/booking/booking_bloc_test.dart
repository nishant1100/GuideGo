import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guide_go/core/error/failure.dart';
import 'package:guide_go/features/booking/domain/entity/book_guide_entity.dart';
import 'package:guide_go/features/booking/domain/entity/guide_entity.dart';
import 'package:guide_go/features/booking/domain/use_case/booking_usecase.dart';
import 'package:guide_go/features/booking/domain/use_case/delete_booking_usecase.dart';
import 'package:guide_go/features/booking/domain/use_case/get_all_guides_usecase.dart';
import 'package:guide_go/features/booking/domain/use_case/get_all_user_bookings.dart';
import 'package:guide_go/features/booking/presentation/view_model/booking/booking_bloc.dart';
import 'package:guide_go/features/booking/presentation/view_model/booking/booking_event.dart';
import 'package:guide_go/features/booking/presentation/view_model/booking/booking_state.dart';
import 'package:mocktail/mocktail.dart';

// Mock classes
class MockBookingUsecase extends Mock implements BookingUsecase {}

class MockGetAllGuidesUsecase extends Mock implements GetAllGuidesUsecase {}

class MockGetAllUserBookingsUsecase extends Mock
    implements GetAllUserBookingsUsecase {}

class MockDeleteBookingUsecase extends Mock implements DeleteBookingUsecase {}

class MockBuildContext extends Mock implements BuildContext {}

// Fake classes for fallback values
class FakeBookingParams extends Fake implements BookingParams {}

class FakeGetAllUserBookingsParams extends Fake
    implements GetAllUserBookingsPrams {}

class FakeDeleteBookingParams extends Fake implements DeleteBookingParams {}

void main() {
  late BookingBloc bookingBloc;
  late MockBookingUsecase mockBookingUsecase;
  late MockGetAllGuidesUsecase mockGetAllGuidesUsecase;
  late MockGetAllUserBookingsUsecase mockGetAllUserBookingsUsecase;
  late MockDeleteBookingUsecase mockDeleteBookingUsecase;
  late MockBuildContext mockBuildContext;

  setUpAll(() {
    // Register fallback values for custom types
    registerFallbackValue(FakeBookingParams());
    registerFallbackValue(FakeGetAllUserBookingsParams());
    registerFallbackValue(FakeDeleteBookingParams());
  });

  setUp(() {
    mockBookingUsecase = MockBookingUsecase();
    mockGetAllGuidesUsecase = MockGetAllGuidesUsecase();
    mockGetAllUserBookingsUsecase = MockGetAllUserBookingsUsecase();
    mockDeleteBookingUsecase = MockDeleteBookingUsecase();
    mockBuildContext = MockBuildContext();

    bookingBloc = BookingBloc(
      bookingUsecase: mockBookingUsecase,
      getAllGuidesUsecase: mockGetAllGuidesUsecase,
      getAllUserBookingsUseCase: mockGetAllUserBookingsUsecase,
      deleteBookingUseCase: mockDeleteBookingUsecase,
    );
  });

  tearDown(() {
    bookingBloc.close();
  });

  group('BookingBloc', () {
    const String pickupDate = '2023-10-01';
    const String pickupTime = '10:00';
    const String noofPeople = '2';
    const String pickupType = 'Car';
    const String pickupLocation = 'New York';
    const String userId = 'user1';
    const String guideId = 'guide1';
    const String bookingId = 'booking1';

    blocTest<BookingBloc, BookingState>(
      'emits [isLoading: true, isSuccess: true] when BookGuideEvent is added and booking is successful',
      build: () {
        when(() => mockBookingUsecase.call(any()))
            .thenAnswer((_) async => const Right(null));
        return bookingBloc;
      },
      act: (bloc) => bloc.add(BookGuideEvent(
        context: mockBuildContext,
        pickupDate: pickupDate,
        pickupTime: pickupTime,
        noofPeople: noofPeople,
        pickupType: pickupType,
        pickupLocation: pickupLocation,
        userId: userId,
        guideId: guideId,
      )),
      expect: () => [
        bookingBloc.state.copyWith(isLoading: true,isSuccess: false),
        bookingBloc.state.copyWith(isLoading: false, isSuccess: true),
      ],
    );

    blocTest<BookingBloc, BookingState>(
      'emits [isLoading: true, isSuccess: false] when BookGuideEvent is added and booking fails',
      build: () {
        when(() => mockBookingUsecase.call(any())).thenAnswer(
            (_) async => const Left(ApiFailure(message: "Booking failed")));
        return bookingBloc;
      },
      act: (bloc) => bloc.add(BookGuideEvent(
        context: mockBuildContext,
        pickupDate: pickupDate,
        pickupTime: pickupTime,
        noofPeople: noofPeople,
        pickupType: pickupType,
        pickupLocation: pickupLocation,
        userId: userId,
        guideId: guideId,
      )),
      expect: () => [
        bookingBloc.state.copyWith(isLoading: true),
        bookingBloc.state.copyWith(isLoading: false, isSuccess: false),
      ],
    );




    blocTest<BookingBloc, BookingState>(
      'emits [isLoading: true, isSuccess: true] when CancelBooking is added and cancellation is successful',
      build: () {
        when(() => mockDeleteBookingUsecase.call(any()))
            .thenAnswer((_) async => const Right(null));
        return bookingBloc;
      },
      act: (bloc) => bloc.add(CancelBooking(
        bookingId: bookingId,
        context: mockBuildContext,
      )),
      expect: () => [
        bookingBloc.state.copyWith(isLoading: true,isSuccess: false),
        bookingBloc.state.copyWith(isLoading: false, isSuccess: true),
      ],
    );
  });
}
