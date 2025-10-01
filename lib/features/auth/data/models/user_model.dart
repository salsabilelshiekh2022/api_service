import 'package:hive_flutter/hive_flutter.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? image;
  @HiveField(3)
  String? phone;
  @HiveField(4)
  Meta? meta;

  UserModel(
      {this.meta,
      required this.id,
      required this.name,
      this.image,
      required this.phone});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['data']['id'];
    name = json['data']['name'];
    image = json['data']['image'] ?? '';
    phone = json['data']['phone'];

    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

@HiveType(typeId: 2)
class Meta {
  @HiveField(0)
  String? message;
  @HiveField(2)
  String? token;
  @HiveField(3)
  String? expiresAt;
  Meta({this.message, this.token, this.expiresAt});

  Meta.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    expiresAt = json['expires_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['token'] = token;
    data['expires_at'] = expiresAt;
    return data;
  }
}
