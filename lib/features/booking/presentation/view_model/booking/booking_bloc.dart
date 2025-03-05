// booking_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guide_go/core/app_theme/common/snackbar/my_snackbar.dart';
import 'package:guide_go/features/booking/domain/use_case/booking_usecase.dart';
import 'package:guide_go/features/booking/domain/use_case/delete_booking_usecase.dart';
import 'package:guide_go/features/booking/domain/use_case/get_all_guides_usecase.dart';
import 'package:guide_go/features/booking/domain/use_case/get_all_user_bookings.dart';
import 'package:guide_go/features/booking/presentation/view_model/booking/booking_event.dart';
import 'package:guide_go/features/booking/presentation/view_model/booking/booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingUsecase _bookingUsecase;
  final GetAllGuidesUsecase _getAllGuidesUsecase;
  final GetAllUserBookingsUsecase _getAllUserBookingsUsecase;
  final DeleteBookingUsecase _deleteBookingUseCase;

  BookingBloc({
    required DeleteBookingUsecase deleteBookingUseCase,
    required BookingUsecase bookingUsecase,
    required GetAllUserBookingsUsecase getAllUserBookingsUseCase,
    required GetAllGuidesUsecase getAllGuidesUsecase,
  })  : _bookingUsecase = bookingUsecase,
        _deleteBookingUseCase = deleteBookingUseCase,
        _getAllUserBookingsUsecase = getAllUserBookingsUseCase,
        _getAllGuidesUsecase = getAllGuidesUsecase,
        super(const BookingState.initial()) {
    on<BookGuideEvent>(_onBookEvent);
    on<GetGudiesEvent>(_getGuides);
    on<GetUserBookingEvent>(_onGetBookingsEvent);
    on<CancelBooking>(_onCancelBooking);
    // add(GetGudiesEvent());
  }

  void _onBookEvent(
    BookGuideEvent event,
    Emitter<BookingState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    // Combine selected guide ID with booking details
    final result = await _bookingUsecase.call(BookingParams(
      pickupDate: event.pickupDate,
      userId: event.userId,
      pickupTime: event.pickupTime,
      noofPeople: event.noofPeople,
      placeImage: event.placeImage,
      pickupType: event.pickupType,
      pickupLocation: event.pickupLocation,
      guideId: event.guideId!, // Use the selected guide ID
    ));

    result.fold(
      (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(context: event.context, message: "Booking Successful");
      },
    );
  }

  void _getGuides(
    GetGudiesEvent event,
    Emitter<BookingState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _getAllGuidesUsecase.call();

    result.fold(
        (failure) => emit(state.copyWith(
              isLoading: false,
              isSuccess: false,
            )), (guides) {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
        guides: guides,
        pickupLocation: state.pickupLocation, // Retain previous data
        pickupDate: state.pickupDate,
        pickupTime: state.pickupTime,
        noofPeople: state.noofPeople,
        pickupType: state.pickupType,
      ));
    });
  }

  void _onGetBookingsEvent(
    GetUserBookingEvent event,
    Emitter<BookingState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    // Combine selected guide ID with booking details
    final result = await _getAllUserBookingsUsecase
        .call(GetAllUserBookingsPrams(userId: event.userId));

    result.fold(
      (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (r) {
        print('Fetched bookings: $r');
        emit(state.copyWith(isLoading: false, isSuccess: true, booking: r));
      },
    );
  }

  void _onCancelBooking(
    CancelBooking event,
    Emitter<BookingState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    // Combine selected guide ID with booking details
    final result = await _deleteBookingUseCase
        .call(DeleteBookingParams(bookingId: event.bookingId));

    result.fold(
      (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(context: event.context, message: "canceled booking Successful");
      },
    );
  }
}
