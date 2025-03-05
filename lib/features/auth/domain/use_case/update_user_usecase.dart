import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:guide_go/app/usecase/usecase.dart';
import 'package:guide_go/core/error/failure.dart';
import 'package:guide_go/features/auth/domain/entity/auth_entity.dart';
import 'package:guide_go/features/auth/domain/repository/auth_repository.dart';


class UpdateUserParams extends Equatable {
  final String userId;
  final String fullName;
  final String username;
  final String phoneNo;
  final String password;
  final String? image;

  const UpdateUserParams(
      {required this.fullName,
      required this.userId,
      required this.username,
      required this.phoneNo,
      required this.password,
      this.image});

  const UpdateUserParams.initial()
      : fullName = '',
        userId='',
        username = '',
        phoneNo = '',
        password = '',
        image = '';

  @override
  List<Object?> get props =>
      [fullName, userId,username, phoneNo, password, image];
}

class UpdateUserUsecase
    implements UsecaseWithParams<BookingEntity, UpdateUserParams> {
  final IAuthRepository authRepository;

  UpdateUserUsecase({required this.authRepository});

  @override
  Future<Either<Failure, BookingEntity>> call(UpdateUserParams params) {
    final authEntity = BookingEntity(
        username: params.username,
        userId: params.userId,
        full_Name: params.fullName,
        phone: params.phoneNo,
        image: params.image,
        password: params.password);

    return authRepository.updateProfile(authEntity);
  }
}
