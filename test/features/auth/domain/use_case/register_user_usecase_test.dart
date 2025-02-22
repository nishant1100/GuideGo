import 'package:flutter_test/flutter_test.dart';
import 'package:guide_go/core/error/failure.dart';
import 'package:guide_go/features/auth/domain/entity/auth_entity.dart';
import 'package:guide_go/features/auth/domain/repository/auth_repository.dart';
import 'package:guide_go/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

// Mock repository class
class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late MockAuthRepository repository;
  late RegisterUseCase usecase;

  // Setup before each test
  setUp(() {
    repository = MockAuthRepository();
    usecase = RegisterUseCase(repository);
    // Register a fallback value for any AuthEntity mock
    registerFallbackValue(const BookingEntity(
      userId: '',
      full_Name: '',
      image: '',
      phone: '',
      username: '',
      password: '',
    ));
  });

  // Define sample RegisterUserParams for tests
  const params = RegisterUserParams(
    full_name: 'Roshan Shrestha',
    phone: '9878909879',
    image: 'picture.png',
    username: 'roshan8',
    password: 'stha1010',
  );

  // Test case 1: Should register user successfully
  test('should register user successfully', () async {
    // Arrange
    when(() => repository.registerUser(any())).thenAnswer(
      (_) async => const Right(null),
    );

    // Act
    final result = await usecase(params);

    // Assert
    expect(result, const Right(null));
    verify(() => repository.registerUser(any())).called(1);
    verifyNoMoreInteractions(repository);
  });

  // Test case 2: Should return ApiFailure when registration fails
  test('should return ApiFailure when user registration fails', () async {
    // Arrange
    const failure = ApiFailure(message: "Registration failed");
    when(() => repository.registerUser(any())).thenAnswer(
      (_) async => const Left(failure),
    );

    // Act
    final result = await usecase(params);

    // Assert
    expect(result, const Left(failure));
    verify(() => repository.registerUser(any())).called(1);
    verifyNoMoreInteractions(repository);
  });
}
