class SocialMediaResponseModel {
  final SocialMediaData data;
  final bool success;

  SocialMediaResponseModel({
    required this.data,
    required this.success,
  });

  factory SocialMediaResponseModel.fromJson(Map<String, dynamic> json) {
    return SocialMediaResponseModel(
      data: SocialMediaData.fromJson(json['data']),
      success: json['success'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.toJson(),
      'success': success,
    };
  }
}

// social_media_data_model.dart
class SocialMediaData {
  final String? facebook;
  final String? instagram;
  final String? twitter;
  final String? tiktok;
  final String? whatsapp;
  final String? youtube;

  SocialMediaData({
    this.facebook,
    this.instagram,
    this.twitter,
    this.tiktok,
    this.whatsapp,
    this.youtube,
  });

  factory SocialMediaData.fromJson(Map<String, dynamic> json) {
    return SocialMediaData(
      facebook: json['facebook'],
      instagram: json['instagram'],
      twitter: json['twitter'],
      tiktok: json['tiktok'],
      whatsapp: json['whatsapp'],
      youtube: json['youtube'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'facebook': facebook,
      'instagram': instagram,
      'twitter': twitter,
      'tiktok': tiktok,
      'whatsapp': whatsapp,
      'youtube': youtube,
    };
  }
}
