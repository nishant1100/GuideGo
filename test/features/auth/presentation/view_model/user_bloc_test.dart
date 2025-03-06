import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guide_go/features/auth/domain/entity/auth_entity.dart';
import 'package:guide_go/features/auth/domain/use_case/get_user_data_usecase.dart';
import 'package:guide_go/features/auth/domain/use_case/update_user_usecase.dart';
import 'package:guide_go/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:guide_go/features/auth/presentation/view_model/useer/user_bloc.dart';
import 'package:guide_go/features/auth/presentation/view_model/useer/user_event.dart';
import 'package:guide_go/features/auth/presentation/view_model/useer/user_state.dart';
import 'package:mocktail/mocktail.dart';

// Mock classes with proper implementation
class MockUpdateUserUsecase extends Mock implements UpdateUserUsecase {}

class MockGetUserDataUsecase extends Mock implements GetUserDataUsecase {}

class MockUploadImageUsecase extends Mock implements UploadImageUsecase {}

class MockFile extends Mock implements File {}

// Create a concrete mock BuildContext that provides a non-null widget
class MockBuildContext extends Mock implements BuildContext {
  @override
  Widget get widget => const SizedBox(); // Provide a non-null widget
}

void main() {
  late UserBloc userBloc;
  late MockUpdateUserUsecase mockUpdateUserUsecase;
  late MockGetUserDataUsecase mockGetUserDataUsecase;
  late MockUploadImageUsecase mockUploadImageUsecase;
  late MockBuildContext mockContext;
  late MockFile mockFile;

  setUpAll(() {
    // Register fallback values for custom types
    registerFallbackValue(const UpdateUserParams(
      userId: 'dummyUserId',
      fullName: 'dummyFullName',
      username: 'dummyUsername',
      phoneNo: 'dummyPhoneNo',
      password: 'dummyPassword',
      image: 'dummyImage',
    ));

    registerFallbackValue(GetUserParams(userId: 'dummyUserId'));

    registerFallbackValue(UploadImageParams(image: File('dummyPath')));
  });

  setUp(() {
    mockUpdateUserUsecase = MockUpdateUserUsecase();
    mockGetUserDataUsecase = MockGetUserDataUsecase();
    mockUploadImageUsecase = MockUploadImageUsecase();
    mockContext = MockBuildContext();
    mockFile = MockFile();

    userBloc = UserBloc(
      updateUserUsecase: mockUpdateUserUsecase,
      getUserDataUsecase: mockGetUserDataUsecase,
      uploadImageUsecase: mockUploadImageUsecase,
    );
  });

  tearDown(() {
    userBloc.close();
  });

  // Test for UpdateUser event
  blocTest<UserBloc, UserState>(
    'emits [loading, success] when UpdateUser event is added and update is successful',
    build: () {
      when(() => mockUpdateUserUsecase.call(any()))
          .thenAnswer((_) async => const Right(BookingEntity(
                userId: '123',
                username: 'johndoe',
                full_Name: 'John Doe',
                phone: '1234567890',
                password: 'password',
                image: 'image_url',
              ))); // Success returns BookingEntity
      return userBloc;
    },
    act: (bloc) => bloc.add(UpdateUser(
      context: mockContext,
      userId: '123',
      fullName: 'John Doe',
      userName: 'johndoe',
      phoneNo: '1234567890',
      password: 'password',
      image: 'image_url',
    )),
    expect: () => [
      const UserState(
        isLoading: true,
        isSuccess: false,
        userId: '',
        username: '',
        fullName: '',
        phoneNo: '',
        password: '',
        image: '',
        profileUpdated: false, // Default to false
        email: '', // Default empty string
      ),
      const UserState(
        isLoading: false,
        isSuccess: true,
        profileUpdated: true, // This is updated in success case
        userId: '123',
        username: 'johndoe',
        fullName: 'John Doe',
        phoneNo: '1234567890',
        password: 'password',
        image: 'image_url',
        email: '', // Ensure email matches the expected value
      ),
    ],
    verify: (_) {
      verify(() => mockUpdateUserUsecase.call(any())).called(1);
    },
  );
}
