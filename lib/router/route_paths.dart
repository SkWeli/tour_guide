class Routes {
  static const splash = '/splash';
  static const login = '/login';
  static const otp = '/otp';
  static const dashboard = '/dashboard';
  static const bookings = '/bookings';
  static String bookingDetail(String id) => '/bookings/$id';
  static const chat = '/chat';
  static String chatThread(String id) => '/chat/$id';
  static const profile = '/profile';
  static const settings = '/settings';
}