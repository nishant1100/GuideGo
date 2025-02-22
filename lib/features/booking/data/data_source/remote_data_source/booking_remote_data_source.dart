import 'dart:io';

import 'package:dio/dio.dart';
import 'package:guide_go/app/constants/api_endpoints.dart';
import 'package:guide_go/features/booking/data/data_source/booking_data_source.dart';
import 'package:guide_go/features/booking/domain/entity/book_guide_entity.dart';


class BookingRemoteDataSource implements IBookingDataSource {
  final Dio _dio;

  BookingRemoteDataSource(this._dio);


  @override
  Future<void> bookGuide(BookGuideEntity entity)async {
       try {
      Response response = await _dio.post(ApiEndpoints.bookGuide, data: {
        "userId": entity.userId,
        "pickupDate": entity.pickupDate,
        "pickupTime": entity.pickupTime,
        "pickupLocation":entity.pickupLocation,
        "pickupType": entity.pickupType,
        "noofPeople": entity.noofPeople
      });
      if (response.statusCode == 201) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}
