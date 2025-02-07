import 'package:flutter_test/flutter_test.dart';
import 'package:guide_go/features/auth/data/model/auth_api_model.dart';
import 'package:guide_go/features/auth/domain/entity/auth_entity.dart';

void main() {
  group('AuthApiModel Tests', () {
    final json = {
      'full_name': 'Robin Stha',
      'username': 'robinstha',
      'phone': '9867890987',
      'password': 'robin100',
      'image': 'profile.jpg',
    };

    test('should convert from JSON correctly', () {
      final model = AuthApiModel.fromJson(json);
      expect(model.full_name, 'Robin Stha');
      expect(model.username, 'robinstha');
      expect(model.phone, '9867890987');
      expect(model.password, 'robin100');
      expect(model.image, 'profile.jpg');
    });

    test('should convert to JSON correctly', () {
      final model = AuthApiModel.fromJson(json);
      final convertedJson = model.toJson();

      //expect(convertedJson['_id'], '123');
      expect(convertedJson['full_name'], 'Robin Stha');
      expect(convertedJson['username'], 'robinstha');
    });

    test('should convert between Entity and Model correctly', () {
      const entity = AuthEntity(
        //userId: '123',
        username: 'robinstha',
        full_Name: 'Robin Stha',
        password: 'robin100',
        image: 'profile.jpg',
        phone: '9867890987',
      );

      final model = AuthApiModel.fromEntiy(entity);
      final convertedEntity = model.toEntity();

      expect(convertedEntity, equals(entity));
    });
  });
}
