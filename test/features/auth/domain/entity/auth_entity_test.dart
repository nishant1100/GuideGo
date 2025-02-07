import 'package:flutter_test/flutter_test.dart';
import 'package:guide_go/features/auth/domain/entity/auth_entity.dart';


void main() {
  const auth1 = AuthEntity(
    userId: "2343423123124",
    full_Name: "Robin Shrestha",
    image: "image_url",
    username: "robinstha",
    password: "robin1010", 
    phone: "9802100278",
  );

  const auth2 = AuthEntity(
    userId: "2343423123124",
    full_Name: "Robin Shrestha",
    image: "image_url",
    username: "robinstha",
    password: "robin1010", 
    phone: '9802100278',
  );
  test('Test 2:  Two AuthEntity objects with the same values should be equal',
      () {
    expect(auth1, auth2); // Should be equal to itself
  });
}
