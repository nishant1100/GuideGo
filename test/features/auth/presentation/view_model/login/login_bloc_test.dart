import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guide_go/app/shared_prefs/token_shared_prefs.dart';
import 'package:guide_go/core/error/failure.dart';
import 'package:guide_go/features/auth/domain/use_case/login_user_usecase.dart';
import 'package:guide_go/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:guide_go/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:guide_go/features/home/presentation/view_model/home_cubit.dart';
import 'package:mocktail/mocktail.dart';

import '../user_bloc_test.dart';

// Mocks
class MockRegisterBloc extends Mock implements RegisterBloc {}

class MockHomeCubit extends Mock implements HomeCubit {}

class MockLoginUsecase extends Mock implements LoginUsecase {}

class MockTokenSharedPrefs extends Mock implements TokenSharedPrefs {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class FakeLoginParams extends Fake implements LoginParams {}

void main() {
  late LoginBloc loginBloc;
  late MockRegisterBloc mockRegisterBloc;
  late MockHomeCubit mockHomeCubit;
  late MockLoginUsecase mockLoginUsecase;
  late MockTokenSharedPrefs mockTokenSharedPrefs;

  setUpAll(() {
    // Register the fallback value for LoginParams
    registerFallbackValue(FakeLoginParams());
  });

  setUp(() {
    mockRegisterBloc = MockRegisterBloc();
    mockHomeCubit = MockHomeCubit();
    mockLoginUsecase = MockLoginUsecase();
    mockTokenSharedPrefs = MockTokenSharedPrefs();
    loginBloc = LoginBloc(
      registerBloc: mockRegisterBloc,
      homeCubit: mockHomeCubit,
      loginUseCase: mockLoginUsecase,
      tokenSharedPrefs: mockTokenSharedPrefs,
    );
  });

  tearDown(() {
    loginBloc.close();
  });

  group('LoginBloc', () {
    test('initial state is LoginState.initial()', () {
      expect(loginBloc.state, LoginState.initial());
    });

    blocTest<LoginBloc, LoginState>(
      'emits [loading, success] when LoginUserEvent is added and login is successful',
      build: () {
        when(() => mockLoginUsecase.call(any())).thenAnswer(
          (_) async => Right({
            'token': 'test_token',
            'userId': '123',
          }),
        );
        when(() => mockTokenSharedPrefs.saveToken(any())).thenAnswer(
          (_) async => const Right(null), // Simulate successful token save
        );
        when(() => mockTokenSharedPrefs.saveUserData(any())).thenAnswer(
          (_) async => const Right(null), // Simulate successful user data save
        );
        return loginBloc;
      },
      act: (bloc) => bloc.add(LoginUserEvent(
        context: MockBuildContext(),
        username: 'testUser',
        password: 'password123',
      )),
      expect: () => [
        const LoginState(isLoading: true, isSuccess: false),
        const LoginState(isLoading: false, isSuccess: true),
      ],
      verify: (_) {
        verify(() => mockLoginUsecase.call(any())).called(1);
        verify(() => mockTokenSharedPrefs.saveToken('test_token')).called(1);
        verify(() => mockTokenSharedPrefs.saveUserData(any())).called(1);
      },
    );

    blocTest<LoginBloc, LoginState>(
      'emits [loading, failure] when LoginUserEvent is added and login fails',
      build: () {
        when(() => mockLoginUsecase.call(any())).thenAnswer(
          (_) async => const Left(ApiFailure(message: 'Login failed')),
        );
        when(() => mockTokenSharedPrefs.saveToken(any())).thenAnswer(
          (_) async => const Right(null), // Simulate successful token save
        );
        when(() => mockTokenSharedPrefs.saveUserData(any())).thenAnswer(
          (_) async => const Right(null), // Simulate successful user data save
        );
        return loginBloc;
      },
      act: (bloc) => bloc.add(LoginUserEvent(
        context: MockBuildContext(),
        username: 'testUser',
        password: 'password123',
      )),
      expect: () => [
        const LoginState(isLoading: true, isSuccess: false),
        const LoginState(isLoading: false, isSuccess: false),
      ],
      verify: (_) {
        verify(() => mockLoginUsecase.call(any())).called(1);
        verifyNever(() => mockTokenSharedPrefs.saveToken(any()));
        verifyNever(() => mockTokenSharedPrefs.saveUserData(any()));
      },
    );
  });
}
