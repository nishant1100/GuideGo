import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guide_go/core/error/failure.dart';
import 'package:guide_go/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:guide_go/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:guide_go/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:guide_go/features/auth/presentation/view_model/signup/register_event.dart';
import 'package:mocktail/mocktail.dart';

// Mocks for the use cases
class MockRegisterUseCase extends Mock implements RegisterUseCase {}

class MockUploadImageUsecase extends Mock implements UploadImageUsecase {}

void main() {
  late RegisterBloc registerBloc;
  late MockRegisterUseCase mockRegisterUseCase;
  late MockUploadImageUsecase mockUploadImageUsecase;

  setUpAll(() {
    // Register fallback values
    registerFallbackValue(
        UploadImageParams(image: File('mock_image_path.jpg')));
    registerFallbackValue(const RegisterUserParams(
      full_name: 'John Doe',
      phone: '1234567890',
      username: 'john_doe',
      password: 'password123',
      image: 'mock_image_path.jpg',
    ));
  });

  setUp(() {
    mockRegisterUseCase = MockRegisterUseCase();
    mockUploadImageUsecase = MockUploadImageUsecase();
    registerBloc = RegisterBloc(
      registerUseCase: mockRegisterUseCase,
      uploadImageUsecase: mockUploadImageUsecase,
    );
  });

  tearDown(() {
    registerBloc.close();
  });

  group('RegisterBloc', () {
    blocTest<RegisterBloc, RegisterState>(
      'emits [loading, success] when UploadImageEvent is added and image upload is successful',
      build: () {
        when(() => mockUploadImageUsecase.call(any()))
            .thenAnswer((_) async => const Right('mock_image_path.jpg'));
        return registerBloc;
      },
      act: (bloc) => bloc.add(UploadImageEvent(
        context: MockBuildContext(),
        img: File('mock_image_path.jpg'),
      )),
      expect: () => [
        RegisterState(isLoading: true, isSuccess: false, imageName: null),
        RegisterState(
            isLoading: false,
            isSuccess: true,
            imageName: 'mock_image_path.jpg'),
      ],
    );

    blocTest<RegisterBloc, RegisterState>(
      'emits [loading, success] when RegisterUser event is added and registration is successful',
      build: () {
        when(() => mockRegisterUseCase.call(any())).thenAnswer(
          (_) async => const Right('Registration successful'),
        );
        return registerBloc;
      },
      act: (bloc) => bloc.add(RegisterUser(
        context: MockBuildContext(),
        full_Name: 'John Doe',
        phone: '1234567890',
        username: 'john_doe',
        password: 'password123',
        image: 'mock_image_path.jpg',
      )),
      expect: () => [
        RegisterState(isLoading: true, isSuccess: false, imageName: null),
        RegisterState(isLoading: false, isSuccess: true, imageName: "mock_image_path.jpg"),
      ],
    );

    blocTest<RegisterBloc, RegisterState>(
      'emits [loading, failure] when RegisterUser event is added and registration fails',
      build: () {
        when(() => mockRegisterUseCase.call(any())).thenAnswer(
          (_) async => const Left(ApiFailure(message: 'Registration failed')),
        );
        return registerBloc;
      },
      act: (bloc) => bloc.add(RegisterUser(
        context: MockBuildContext(),
        full_Name: 'John Doe',
        phone: '1234567890',
        username: 'john_doe',
        password: 'password123',
        image: 'mock_image_path.jpg',
      )),
      expect: () => [
        RegisterState(isLoading: true, isSuccess: false, imageName: null),
        RegisterState(isLoading: false, isSuccess: false, imageName: null),
      ],
    );
  });
}

// Mock BuildContext
class MockBuildContext extends Mock implements BuildContext {}
