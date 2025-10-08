import 'booking.dart';

abstract class BookingsRepository {
  Future<List<Booking>> listMine();
}
