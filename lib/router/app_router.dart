import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/auth/presentation/login_page.dart';
import '../features/auth/presentation/splash_gate.dart';
import '../features/dashboard/presentation/dashboard_page.dart';
import '../features/bookings/presentation/bookings_page.dart';
import '../features/bookings/presentation/booking_detail_page.dart';
import 'route_paths.dart';

final _routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: Routes.splash,
    routes: [
      GoRoute(path: Routes.splash, builder: (c, s) => const SplashGate()),
      GoRoute(path: Routes.login, builder: (c, s) => const LoginPage()),
      GoRoute(path: Routes.dashboard, builder: (c, s) => const DashboardPage()),
      GoRoute(path: Routes.bookings, builder: (c, s) => const BookingsPage()),
      GoRoute(
        path: '/bookings/:id',
        builder: (c, s) => BookingDetailPage(id: s.pathParameters['id']!),
      ),
    ],
  );
});

GoRouter get appRouter => _container.read(_routerProvider);
final _container = ProviderContainer();
