class Booking {
  final String id;
  final String status;
  final DateTime? startTime;
  final DateTime? endTime;
  final String? meetingPointAddress;

  Booking({
    required this.id,
    required this.status,
    this.startTime,
    this.endTime,
    this.meetingPointAddress,
  });

  factory Booking.fromMap(Map<String, dynamic> m) => Booking(
        id: m['id'] as String,
        status: m['status'] as String,
        startTime: m['start_time'] != null ? DateTime.parse(m['start_time']) : null,
        endTime: m['end_time'] != null ? DateTime.parse(m['end_time']) : null,
        meetingPointAddress: m['meeting_point_address'] as String?,
      );
}
