import 'package:equatable/equatable.dart';

class BookingEntity extends Equatable {
  final String? userId;
  final String full_Name;
  final String? image;
  final String phone;
  final String username;
  final String password;

  const BookingEntity({
    this.userId,
    required this.full_Name,
    this.image,
    required this.phone,
    required this.username,
    required this.password,
  });

  @override
  List<Object?> get props =>
      [userId, full_Name, image, phone, username, password];
}
