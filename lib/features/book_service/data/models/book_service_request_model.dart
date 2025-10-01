import 'package:dio/dio.dart';

import 'report_type_enum.dart';

class BookServiceRequestModel {
  String? fullName;
  String? phone;
  // int carBrandId;
  int carModelId;
  int carModelYear;
  String dateTimeoFBooking;
  String? notes;
  int serviceId;
  ReportTypeEnum reportType;
  List<String>? images; // List of image file paths

  BookServiceRequestModel(
      {this.fullName,
      this.phone,
      //required this.carBrandId,
      required this.carModelId,
      required this.carModelYear,
      required this.dateTimeoFBooking,
      this.notes,
      required this.serviceId,
      required this.reportType,
      this.images}); // Added images parameter

  factory BookServiceRequestModel.fromJson(Map<String, dynamic> json) {
    return BookServiceRequestModel(
      fullName: json['name'],
      phone: json['phone'],
      // carBrandId: json['car_brand_id'],
      carModelId: json['car_model_id'],
      carModelYear: json['car_model_year'],
      dateTimeoFBooking: json['date_time'],
      notes: json['notes'],
      serviceId: json['service_id'],
      reportType: ReportTypeEnum.values.firstWhere(
          (e) => e.name == json['report_type'],
          orElse: () => ReportTypeEnum.buy_and_sell), // Default value
      images: json['images'] != null
          ? List<String>.from(json['images'])
          : null, // Handle images from JSON
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'name': fullName,
      'phone': phone,
      //'car_brand_id': carBrandId,
      'car_model_id': carModelId,
      'car_model_year': carModelYear,
      'date_time': dateTimeoFBooking,
      'notes': notes,
      'service_id': serviceId,
      'report_type': reportType.name,
    };

    // Add images as MultipartFile objects if they exist
    if (images != null && images!.isNotEmpty) {
      for (int i = 0; i < images!.length; i++) {
        json['images[$i]'] = MultipartFile.fromFileSync(images![i]);
      }
    }

    return json;
  }
}
