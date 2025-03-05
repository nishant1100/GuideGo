class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  // static const String baseUrl = "http://10.0.2.2:3000/api";
    static const String baseUrl = "http://192.168.1.66:3000/api";
        static const String imagebaseUrl = "http://192.168.1.66:3000/place_images/";

        // static const String baseUrl = "http://192.168.1.66:3000/api";
        // static const String imagebaseUrl = "http://192.168.1.66:3000/place_images/";



  //=====================Auth Routes===============================
  static const String registerUser="/auth/register";
  static const String loginUser = "/auth/login";
  static const String uploadImage = "/user/uploadimage";
  static const String updateProfile = "/auth/";
  static const String getUserbyId = "/auth/";


  static const String bookGuide = "/hire/";
  static const String getAllGuides = "/guide/guides";
  static const String deleteBooking = "/hire/delete/";

  static const String getUserBookings="/hire/user/";

}