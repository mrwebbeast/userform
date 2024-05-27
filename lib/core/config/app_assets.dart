class AppAssets {
  /// 1) Icons...

  static const String homeIcon = "assets/icons/ic_home.png";
  static const String bookingsIcon = "assets/icons/bookings_icon.png";
  static const String tipsTricksIcon = "assets/icons/ic_tips.png";
  static const String profileIcon = "assets/icons/ic_profile.png";

  /// 2) Images...

  static const String appIcon = "assets/images/appIcon.png";
  static const String noImage = "assets/images/no_image.png";
  static const String avatarImage = "assets/images/avatar_image.png";
  static const String noInternetConnection = "assets/images/no-internet-connection.png";
  ///3)  Json...

  static const String surpriseJson = "assets/lottie/surprise.json";
  static const String winnerJson = "assets/lottie/winner.json";

  static String getCountryFlag({required String? countryCode}) {
    return "assets/flags/$countryCode.png";
  }
}
