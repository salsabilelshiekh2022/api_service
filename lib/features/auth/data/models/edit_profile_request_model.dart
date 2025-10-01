import 'package:dio/dio.dart';

class EditProfileRequestModel {
  final String? name;
  final String? phoneNumber;
  final String? image;

  EditProfileRequestModel({
    this.name,
    this.phoneNumber,
    this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phoneNumber,
      'image': image != null
          ? MultipartFile.fromFileSync(
              image!,
            )
          : null,
    };
  }
}
