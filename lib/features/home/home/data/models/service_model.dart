class ServiceModel {
  final int id;
  final String name;
  final String mainImage;

  ServiceModel({required this.id, required this.name, required this.mainImage});

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      name: json['name'],
      mainImage: json['main_image'],
    );
  }

  Map<String, dynamic> toJson() =>
      {'id': id, 'name': name, 'main_image': mainImage};
}

ServiceModel dummyService = ServiceModel(id: -1, name: '', mainImage: '');
