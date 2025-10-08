import 'package:flutter/material.dart';

class BookingDetailPage extends StatelessWidget {
  const BookingDetailPage({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Booking $id')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text('TODO: show booking details + actions'),
      ),
    );
  }
}
