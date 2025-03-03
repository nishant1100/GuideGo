import 'dart:io';

import 'package:guide_go/core/network/hive_service.dart';
import 'package:guide_go/features/auth/data/data_source/auth_data_source.dart';
import 'package:guide_go/features/auth/data/model/auth_user_model.dart';
import 'package:guide_go/features/auth/domain/entity/auth_entity.dart';
import 'package:guide_go/features/booking/data/data_source/booking_data_source.dart';
import 'package:guide_go/features/booking/data/model/booking_hive_model.dart';
import 'package:guide_go/features/booking/domain/entity/book_guide_entity.dart';
import 'package:guide_go/features/booking/domain/entity/guide_entity.dart';

class BookGuideLocalDataSource implements IBookingDataSource {
  final HiveService _hiveService;

  BookGuideLocalDataSource(this._hiveService);



  @override
  Future<void> bookGuide(BookGuideEntity entity) async {
    try {
      var bookingModel = BookingHiveModel.fromEntity(entity);
      await _hiveService.bookGuide(bookingModel);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<GuideEntity>> getAllGuides() async {
    //  try{
    //   var guides = await _hiveService.getAllGuides();
    //   return guides;
    // }
    // catch(e){
    //   throw Exception(e);

    // }
    return [];
  }

  @override
  Future<List<BookGuideEntity>> getUserBookings(String userId) async {
    var data = await _hiveService.getUserBooking(userId);
    var lest = BookingHiveModel.toEntityList(data);
    print(lest);
    return lest;
  }
}
