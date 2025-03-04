class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://10.0.2.2:3000/api";
    //static const String baseUrl = "http://192.168.1.64:3000/api";

  //=====================Auth Routes===============================
  static const String registerUser="/auth/register";
  static const String loginUser = "/auth/login";
  static const String uploadImage = "/user/uploadimage";


  static const String bookGuide = "/hire/";
  static const String getAllGuides = "/guide/guides";

  static const String getUserBookings="/hire/user/";

}