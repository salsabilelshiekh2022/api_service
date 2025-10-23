class CarTypesResponse {
  final List<CarType> data;
  final bool success;
  final CarTypesMeta meta;

  CarTypesResponse({
    required this.data,
    required this.success,
    required this.meta,
  });

  factory CarTypesResponse.fromJson(Map<String, dynamic> json) {
    return CarTypesResponse(
      data:
          (json['data'] as List).map((item) => CarType.fromJson(item)).toList(),
      success: json['success'] ?? false,
      meta: CarTypesMeta.fromJson(json['meta'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((item) => item.toJson()).toList(),
      'success': success,
      'meta': meta.toJson(),
    };
  }
}

// Car type model
class CarType {
  final int id;
  final String name;
  final String icon;

  CarType({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory CarType.fromJson(Map<String, dynamic> json) {
    return CarType(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      icon: json['icon'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
    };
  }

  @override
  String toString() {
    return 'CarType{id: $id, name: $name, icon: $icon}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CarType && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

// Meta model for car types response
class CarTypesMeta {
  final String? message;

  CarTypesMeta({this.message});

  factory CarTypesMeta.fromJson(Map<String, dynamic> json) {
    return CarTypesMeta(
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
    };
  }
}
