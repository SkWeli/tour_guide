import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/bookings_repository.dart';
import '../domain/booking.dart';
import '../data/repository_impl.dart';
import '../data/remote_sources.dart';

final bookingsRepositoryProvider = Provider<BookingsRepository>((ref) {
  return BookingsRepositoryImpl(BookingsRemoteSource());
});

final bookingsListProvider = StateNotifierProvider<BookingsListController, AsyncValue<List<Booking>>>(
  (ref) => BookingsListController(ref),
);

class BookingsListController extends StateNotifier<AsyncValue<List<Booking>>> {
  BookingsListController(this._ref) : super(const AsyncLoading()) {
    load();
  }

  final Ref _ref;

  Future<void> load() async {
    final repo = _ref.read(bookingsRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => repo.listMine());
  }
}
