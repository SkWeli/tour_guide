import '../domain/bookings_repository.dart';
import '../domain/booking.dart';
import 'remote_sources.dart';

class BookingsRepositoryImpl implements BookingsRepository {
  BookingsRepositoryImpl(this._remote);
  final BookingsRemoteSource _remote;

  @override
  Future<List<Booking>> listMine() async {
    final rows = await _remote.listMineRaw();
    return rows.map(Booking.fromMap).toList();
  }
}
