class ServiceDetailResponse {
  final ServiceDetailData data;
  final bool success;
  final Meta meta;

  ServiceDetailResponse({
    required this.data,
    required this.success,
    required this.meta,
  });

  factory ServiceDetailResponse.fromJson(Map<String, dynamic> json) {
    return ServiceDetailResponse(
      data: ServiceDetailData.fromJson(json['data']),
      success: json['success'] ?? false,
      meta: Meta.fromJson(json['meta']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.toJson(),
      'success': success,
      'meta': meta.toJson(),
    };
  }
}

// Service detail data model
class ServiceDetailData {
  final int id;
  final String name;
  final String mainImage;
  final String interiorImage;
  final String shortDesc;
  final String longDesc;
  final double estimatePrice;
  final int reviewsCount;
  final double rateAvg;
  final List<ServiceImage> images;
  final List<ServiceRate> rates;

  ServiceDetailData({
    required this.id,
    required this.name,
    required this.mainImage,
    required this.interiorImage,
    required this.shortDesc,
    required this.longDesc,
    required this.estimatePrice,
    required this.reviewsCount,
    required this.rateAvg,
    required this.images,
    required this.rates,
  });

  factory ServiceDetailData.fromJson(Map<String, dynamic> json) {
    return ServiceDetailData(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      mainImage: json['main_image'] ?? '',
      interiorImage: json['interior_image'] ?? '',
      shortDesc: json['short_desc'] ?? '',
      longDesc: json['long_dec'] ?? '', // Note: typo in API response
      estimatePrice: (json['estimate_price'] ?? 0).toDouble(),
      reviewsCount: json['reviews_count'] ?? 0,
      rateAvg: (json['rate_avg'] ?? 0).toDouble(),
      images: (json['images'] as List<dynamic>?)
              ?.map((x) => ServiceImage.fromJson(x))
              .toList() ??
          [],
      rates: (json['rates'] as List<dynamic>?)
              ?.map((x) => ServiceRate.fromJson(x))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'main_image': mainImage,
      'interior_image': interiorImage,
      'short_desc': shortDesc,
      'long_dec': longDesc,
      'estimate_price': estimatePrice,
      'reviews_count': reviewsCount,
      'rate_avg': rateAvg,
      'images': images.map((x) => x.toJson()).toList(),
      'rates': rates.map((x) => x.toJson()).toList(),
    };
  }
}

// Service image model
class ServiceImage {
  final String filePath;

  ServiceImage({
    required this.filePath,
  });

  factory ServiceImage.fromJson(Map<String, dynamic> json) {
    return ServiceImage(
      filePath: json['file_path'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'file_path': filePath,
    };
  }
}

// Service rate model (for future use when rates are available)
class ServiceRate {
  final int? id;
  final double? rating;
  final String? comment;
  final String? userName;
  final DateTime? createdAt;

  ServiceRate({
    this.id,
    this.rating,
    this.comment,
    this.userName,
    this.createdAt,
  });

  factory ServiceRate.fromJson(Map<String, dynamic> json) {
    return ServiceRate(
      id: json['id'],
      rating: json['rating']?.toDouble(),
      comment: json['comment'],
      userName: json['user_name'],
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rating': rating,
      'comment': comment,
      'user_name': userName,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}

// Meta model
class Meta {
  final String? message;

  Meta({
    this.message,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
    };
  }
}

ServiceDetailData dummyServiceDetailData = ServiceDetailData(
  id: 1,
  name: 'Service Name',
  mainImage: 'https://via.placeholder.com/150',
  interiorImage: 'https://via.placeholder.com/150',
  shortDesc: 'Short Description',
  longDesc: 'Long Description',
  estimatePrice: 100.0,
  reviewsCount: 5,
  rateAvg: 4.5,
  images: [
    ServiceImage(filePath: 'https://via.placeholder.com/150'),
    ServiceImage(filePath: 'https://via.placeholder.com/150'),
    ServiceImage(filePath: 'https://via.placeholder.com/150'),
  ],
  rates: [
    ServiceRate(
        id: 1,
        rating: 4.5,
        comment: 'Great service!',
        userName: 'John Doe',
        createdAt: DateTime.now()),
    ServiceRate(
        id: 2,
        rating: 4.0,
        comment: 'Good job!',
        userName: 'Jane Smith',
        createdAt: DateTime.now().subtract(Duration(days: 1))),
  ],
);
