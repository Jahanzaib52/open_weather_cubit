class WeatherException implements Exception {
  String message;
  WeatherException({this.message = "Something went Wrong"}) {
    message = "Weather Exception:$message";
  }
  // @override
  // String toString() {
  //   return message;
  // }
}
