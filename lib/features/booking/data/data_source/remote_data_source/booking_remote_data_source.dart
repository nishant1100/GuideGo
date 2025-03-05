import 'package:dio/dio.dart';
import 'package:guide_go/app/constants/api_endpoints.dart';
import 'package:guide_go/features/booking/data/data_source/booking_data_source.dart';
import 'package:guide_go/features/booking/data/dto/get_all_guides_dto.dart';
import 'package:guide_go/features/booking/data/model/booking_api_model.dart';
import 'package:guide_go/features/booking/domain/entity/book_guide_entity.dart';
import 'package:guide_go/features/booking/domain/entity/guide_entity.dart';

class BookingRemoteDataSource implements IBookingDataSource {
  final Dio _dio;

  BookingRemoteDataSource(this._dio);

  @override
  Future<void> bookGuide(BookGuideEntity entity) async {
    try {
      Response response = await _dio.post(ApiEndpoints.bookGuide, data: {
        "userId": entity.userId,
        "pickupDate": entity.pickupDate,
        'placeImage': entity.placeImage,
        "pickupTime": entity.pickupTime,
        "pickupLocation": entity.pickupLocation,
        "pickupType": entity.pickupType,
        "noofPeople": entity.noofPeople,
        "guideId": entity.guide
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

  @override
  Future<List<GuideEntity>> getAllGuides() async {
    try {
      // Sending the GET request to the API
      var response = await _dio.get(ApiEndpoints.getAllGuides);

      // Check if the response is successful (status code 200)
      if (response.statusCode == 200) {
        // Parse JSON response as List
        List<dynamic> jsonData = response.data;

        // Convert raw JSON data into GetAllGuidesDTO objects
        List<GetAllGuidesDTO> guidesDtoList = jsonData
            .map((e) => GetAllGuidesDTO.fromJson(e)) // Mapping to DTO
            .toList();

        // Now convert the DTO list into your GuideEntity list
        List<GuideEntity> guides = guidesDtoList
            .map((dto) => GuideEntity(
                guideId: dto.id,
                full_name: dto.full_name,
                price: dto.price,
                image: dto.image,
                available: dto.available
                    .toString())) // Convert 'available' string to bool
            .toList();

        // Return the final list of GuideEntity objects
        return guides;
      } else {
        // If the status code is not 200, throw an exception with the response's message
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      // Catch Dio-specific exceptions
      throw Exception(e.message);
    } catch (e) {
      // Catch all other exceptions
      throw Exception(e);
    }
  }

  @override
  Future<List<BookGuideEntity>> getUserBookings(String userId) async {
    try {
      var response = await _dio.get('${ApiEndpoints.getUserBookings}$userId');

      if (response.statusCode == 200) {
        List<dynamic> bookingData = response.data;
        print('Data from API: $bookingData');

        // Map API data to BookingApiModel
        List<BookingApiModel> bookingModels =
            bookingData.map((e) => BookingApiModel.fromJson(e)).toList();

        print('Data converted to BookingApiModel: $bookingModels');

        // Convert BookingApiModel to BookGuideEntity
        List<BookGuideEntity> bookings =
            bookingModels.map((e) => e.toEntity()).toList();

        return bookings;
      } else {
        throw Exception("Failed to fetch bookings");
      }
    } on DioException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e);
    }
  }
  
  @override
  Future<void> deleteBooking(String bookingId)async {
   try {
      Response response = await _dio.delete('${ApiEndpoints.deleteBooking}${bookingId}');
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
