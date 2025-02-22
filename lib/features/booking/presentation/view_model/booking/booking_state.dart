part of 'booking_bloc.dart';

class BookingState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? imageName;

  const BookingState({
    required this.isLoading,
    required this.isSuccess,
    this.imageName,
  });

  const BookingState.initial()
      : isLoading = false,
        isSuccess = false,
        imageName = null;

  BookingState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? imageName,
  }) {
    return BookingState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      imageName: imageName ?? this.imageName,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, imageName];
}
