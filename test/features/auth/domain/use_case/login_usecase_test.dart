import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guide_go/core/error/failure.dart';
import 'package:guide_go/features/auth/domain/use_case/login_user_usecase.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo.mock.dart';

void main() {
  late MockAuthRepository repository;
  late LoginUsecase usecase;
  late MockTokenSharedPrefs tokenSharedPrefs;

  setUp(() {
    repository = MockAuthRepository();
    tokenSharedPrefs = MockTokenSharedPrefs();
    usecase = LoginUsecase(repository, tokenSharedPrefs);
  });

  test("should return ApiFailure when credentials are invalid", () async {
  // Arrange
  when(() => repository.loginUser(any(), any()))
      .thenAnswer((_) async => Left(ApiFailure(message: "invalid username or password")));

  // Act
  final result = await usecase(
      const LoginParams(username: "nishant", password: "invalidpass"));

  // Assert
  expect(
    result,
    isA<Left<Failure, String>>().having(
      (l) => (l as Left).value.message,
      'message',
      equals("invalid username or password"), // Fixed to match actual return message
    ),
  );

  verify(() => repository.loginUser("nishant", "invalidpass")).called(1);
  verifyNever(() => tokenSharedPrefs.saveToken(any()));
  verifyNever(() => tokenSharedPrefs.getToken());

  verifyNoMoreInteractions(repository);
  verifyNoMoreInteractions(tokenSharedPrefs);
});


  test("should return ApiFailure when credentials are invalid", () async {
    // Arrange
    when(() => repository.loginUser(any(), any()))
        .thenAnswer((invocation) async {
      final username = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;

      if (username != "ishan" || password != "stha1010") {
        return Left(ApiFailure(message: "invalid username or password"));
      } else {
        return const Right('token');
      }
    });

    // Act
    final result = await usecase(
        const LoginParams(username: "nishant", password: "invalidpass"));

    // Assert
    expect(
      result,
      isA<Left<Failure, String>>().having(
        (l) => (l as Left).value.message,
        'message',
        equals("invalid username or password"),
      ),
    );

    verify(() => repository.loginUser("nishant", "invalidpass"))
        .called(1);
    verifyNever(() => tokenSharedPrefs.saveToken(any()));
    verifyNever(() => tokenSharedPrefs.getToken());

    verifyNoMoreInteractions(repository);
    verifyNoMoreInteractions(tokenSharedPrefs);
  });

  tearDown(() {
    reset(repository);
    reset(tokenSharedPrefs);
  });
}
