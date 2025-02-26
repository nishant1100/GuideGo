import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:guide_go/core/network/api_service.dart';
import 'package:guide_go/core/network/hive_service.dart';
import 'package:guide_go/features/auth/data/data_source/local_data_source/auth_local_data_source.dart';
import 'package:guide_go/features/auth/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:guide_go/features/auth/data/repository/auth_local_repository/auth_local_repository.dart';
import 'package:guide_go/features/auth/data/repository/auth_remote_repository/auth_remote_repository.dart';
import 'package:guide_go/features/auth/domain/repository/auth_repository.dart';
import 'package:guide_go/features/auth/domain/use_case/login_user_usecase.dart';
import 'package:guide_go/features/auth/domain/use_case/register_user_usecase.dart';
import 'package:guide_go/features/auth/domain/use_case/upload_image_usecase.dart';
import 'package:guide_go/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:guide_go/features/auth/presentation/view_model/signup/register_bloc.dart';
import 'package:guide_go/features/booking/data/data_source/remote_data_source/booking_remote_data_source.dart';
import 'package:guide_go/features/booking/data/repository/auth_local_repository/booking_local_repository.dart';
import 'package:guide_go/features/booking/data/repository/booking_remote_repository/booking_remote_repository.dart';
import 'package:guide_go/features/booking/domain/use_case/booking_usecase.dart';
import 'package:guide_go/features/booking/domain/use_case/get_all_guides_usecase.dart';
import 'package:guide_go/features/booking/presentation/view_model/booking/booking_bloc.dart';
import 'package:guide_go/features/home/presentation/view_model/home_bloc.dart';
import 'package:guide_go/features/home/presentation/view_model/home_cubit.dart';
import 'package:guide_go/features/splash/presentation/view_model/splash_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // First initialize hive service
  await _initHiveService();
  await _initApiService();
  // await _initSharedPrefs();
  await _initSplashDependencies();

  await _initHomeDependencies();
  await __initRegisterDependencies();
  await _initLoginDependencies();
  await _initiBookingDependencies();
  // await _initOnboardingDependency();
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initApiService() {
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}

// _initSharedPrefs() async {
//   final sharedPrefs = await SharedPreferences.getInstance();
//   getIt.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
// }

_initLoginDependencies() async {
  //  getIt.registerLazySingleton<TokenSharedPrefs>(
  //   () => TokenSharedPrefs(getIt<SharedPreferences>()));

  //note  ==  // remove getit and update loginuse case to run UI.
  getIt.registerLazySingleton<LoginUsecase>(
    () => LoginUsecase(
      getIt<AuthRemoteRepository>(),
      //getIt(),
    ),
  );

  // Register LoginBloc
  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      registerBloc: getIt<RegisterBloc>(),
      homeCubit: getIt<HomeCubit>(),
      loginUseCase: getIt<LoginUsecase>(),
    ),
  );
}

// _initOnboardingDependency()async{
//     getIt.registerFactory<OnboardingCubit>(() => OnboardingCubit());

// }

__initRegisterDependencies() {
  // Register AuthLocalDataSource
  getIt.registerLazySingleton<BookingLocalDataSource>(
    () => BookingLocalDataSource(getIt<HiveService>()),
  );
  getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(getIt<Dio>()));

  getIt.registerLazySingleton<AuthLocalRepository>(
      () => AuthLocalRepository(getIt()));

  getIt.registerLazySingleton<AuthRemoteRepository>(() => AuthRemoteRepository(
      authRemoteDataSource: getIt<AuthRemoteDataSource>()));

  // Register IAuthRepository
  getIt.registerLazySingleton<IAuthRepository>(
    () => AuthLocalRepository(getIt<BookingLocalDataSource>()),
  );

  // Register RegisterUserUsecase
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(getIt<AuthRemoteRepository>()),
  );

  getIt.registerLazySingleton<UploadImageUsecase>(
      () => UploadImageUsecase(repository: getIt<AuthRemoteRepository>()));

  // Register RegisterBloc
  getIt.registerFactory<RegisterBloc>(
    () => RegisterBloc(
      registerUseCase: getIt<RegisterUseCase>(),
      uploadImageUsecase: getIt<UploadImageUsecase>(),
    ),
  );
}

_initSplashDependencies() async {
  getIt.registerLazySingleton<SplashCubit>(() => SplashCubit(getIt()));
}

_initHomeDependencies() async {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
  getIt.registerFactory<HomeBloc>(
    () => HomeBloc(),
  );
}

_initiBookingDependencies() async {
  // Register BookingLocalDataSource and BookingRemoteDataSource only once

  getIt.registerLazySingleton<BookingRemoteDataSource>(
    () => BookingRemoteDataSource(getIt<Dio>()),
  );

  // Register the repositories
  getIt.registerLazySingleton<BookingLocalRepository>(
    () => BookingLocalRepository(getIt()),
  );
  getIt.registerLazySingleton<BookingRemoteRepository>(
    () => BookingRemoteRepository(
        bookingRemoteDataSource: getIt<BookingRemoteDataSource>()),
  );

  // // Register the IBookingRepository
  // getIt.registerLazySingleton<IBookingRepository>(
  //   () => BookingRemoteRepository(bookingRemoteDataSource: getIt<BookingRemoteDataSource>()),
  // );

  // Register BookingUsecase
  getIt.registerLazySingleton<BookingUsecase>(
    () => BookingUsecase(repository: getIt<BookingRemoteRepository>()),
  );
  getIt.registerLazySingleton<GetAllGuidesUsecase>(
      () => GetAllGuidesUsecase(repository: getIt<BookingRemoteRepository>()));

  // Register BookingBloc
  getIt.registerFactory<BookingBloc>(
    () => BookingBloc(bookingUsecase: getIt(), getAllGuidesUsecase: getIt()),
  );
}
