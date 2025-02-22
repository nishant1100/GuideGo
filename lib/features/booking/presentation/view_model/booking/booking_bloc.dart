import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:guide_go/core/app_theme/common/snackbar/my_snackbar.dart';
import 'package:guide_go/features/booking/domain/use_case/booking_usecase.dart';
import 'package:guide_go/features/booking/presentation/view_model/booking/booking_event.dart';

part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final BookingUsecase _bookingUsecase;
  BookingBloc({
    required BookingUsecase bookingUsecase,
  })  : _bookingUsecase = bookingUsecase,
        super(const BookingState.initial()) {
    on<BookGuideEvent>(_onBookEvent);

    // add(LoadCoursesAndBatches());
  }

  void _onBookEvent(
    BookGuideEvent event,
    Emitter<BookingState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _bookingUsecase.call(BookingParams(
        pickupDate: event.pickupDate,
        userId: event.userId,
        pickupTime: event.pickupTime,
        noofPeople: event.noofPeople,
        pickupType: event.pickupType,
        pickupLocation: event.pickupLocation));
    result.fold(
      (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
            context: event.context, message: "booking Successful");
      },
    );
  }
}
