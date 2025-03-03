import 'package:guide_go/app/constants/hive_table_constant.dart';
import 'package:guide_go/features/auth/data/model/auth_user_model.dart';
import 'package:guide_go/features/booking/data/model/booking_hive_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  static Future<void> init() async {
    // Initialize the database
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}guide_go.db';

    Hive.init(path);

    // Register Adapters
    Hive.registerAdapter(AuthHiveModelAdapter());
    Hive.registerAdapter(BookingHiveModelAdapter());
  }

  // Auth Queries
  Future<void> register(AuthHiveModel auth) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.put(auth.userId, auth);
  }

  Future<void> deleteAuth(String id) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.delete(id);
  }

  Future<List<AuthHiveModel>> getAllAuth() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    return box.values.toList();
  }

  // Login using username and password
  Future<AuthHiveModel?> login(String username, String password) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    var auth = box.values.firstWhere(
        (element) =>
            element.username == username && element.password == password,
        orElse: () => const AuthHiveModel.initial());
    return auth;
  }

  Future<void> bookGuide(BookingHiveModel model) async {
    var box =
        await Hive.openBox<BookingHiveModel>(HiveTableConstant.bookingBox);
    await box.put(model.id, model);
  }

  Future<List<BookingHiveModel>> getUserBooking(String userId) async {
    var box =
        await Hive.openBox<BookingHiveModel>(HiveTableConstant.bookingBox);
    var filteredBookings =
        box.values.where((booking) => booking.userId == userId).toList();
    print("User Booking Entities: $filteredBookings");

    return filteredBookings;
  }

  // Future<List<BookingHiveModel>> getAllGuides()async{
  //     var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
  //   return box.values.toList();
  // }

  Future<void> saveBookingsToHive(List<BookingHiveModel> bookings) async {
  var box = await Hive.openBox<BookingHiveModel>(HiveTableConstant.bookingBox);
  
  // Clear old data (optional)
  await box.clear();

  // Store new data
  for (var booking in bookings) {
    await box.put(booking.id, booking);
  }
  
  print("Bookings saved to Hive: $bookings");
}

  Future<void> clearAll() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
  }

  // Clear User Box
  Future<void> clearUserBox() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
  }

  Future<void> close() async {
    await Hive.close();
  }
}
