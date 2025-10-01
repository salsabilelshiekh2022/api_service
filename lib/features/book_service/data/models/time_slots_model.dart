// time_slot.dart
import 'package:equatable/equatable.dart';

class TimeSlot extends Equatable {
  final String time;
  final DateTime dateTime;
  final bool reserved;

  const TimeSlot({
    required this.time,
    required this.dateTime,
    required this.reserved,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      time: json['time'] as String,
      dateTime: DateTime.parse(json['date_time'] as String),
      reserved: json['reserved'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'date_time': dateTime.toIso8601String(),
      'reserved': reserved,
    };
  }

  TimeSlot copyWith({
    String? time,
    DateTime? dateTime,
    bool? reserved,
  }) {
    return TimeSlot(
      time: time ?? this.time,
      dateTime: dateTime ?? this.dateTime,
      reserved: reserved ?? this.reserved,
    );
  }

  @override
  List<Object?> get props => [time, dateTime, reserved];

  // Convenience getters
  bool get isAvailable => !reserved;

  String get formattedTime => time;

  String get formattedDate => '${dateTime.day.toString().padLeft(2, '0')}/'
      '${dateTime.month.toString().padLeft(2, '0')}/'
      '${dateTime.year}';

  String get formattedDateTime => '${formattedDate} ${time}';

  @override
  String toString() {
    return 'TimeSlot(time: $time, dateTime: $dateTime, reserved: $reserved)';
  }
}

class TimeSlotsResponse extends Equatable {
  final List<TimeSlot> data;
  final bool success;

  const TimeSlotsResponse({
    required this.data,
    required this.success,
  });

  factory TimeSlotsResponse.fromJson(Map<String, dynamic> json) {
    return TimeSlotsResponse(
      data: (json['data'] as List<dynamic>)
          .map((item) => TimeSlot.fromJson(item as Map<String, dynamic>))
          .toList(),
      success: json['success'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((timeSlot) => timeSlot.toJson()).toList(),
      'success': success,
    };
  }

  TimeSlotsResponse copyWith({
    List<TimeSlot>? data,
    bool? success,
  }) {
    return TimeSlotsResponse(
      data: data ?? this.data,
      success: success ?? this.success,
    );
  }

  @override
  List<Object?> get props => [data, success];
}
