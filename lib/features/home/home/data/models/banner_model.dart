class BannerModel {
  final int id;
  final String? action;
  final String image;

  BannerModel(
    this.id,
    this.action,
    this.image,
  );

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      json['id'],
      json['action'],
      json['image'],
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'action': action, 'image': image};

  BannerModel copyWith({
    int? id,
    String? action,
    String? image,
  }) {
    return BannerModel(
      id ?? this.id,
      action ?? this.action,
      image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'action': action,
      'image': image,
    };
  }

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      map['id'] as int,
      map['action'] as String?,
      map['image'] as String,
    );
  }

  @override
  String toString() => 'BannerModel(id: $id, action: $action, image: $image)';

  @override
  bool operator ==(covariant BannerModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.action == action && other.image == image;
  }

  @override
  int get hashCode => id.hashCode ^ action.hashCode ^ image.hashCode;
}

BannerModel dummyBanner = BannerModel(0, '',
    'https://mo7taref.arabapps.cloud/storage/banners/1a941526032e876fc128a63ec7dfb82c.png');
