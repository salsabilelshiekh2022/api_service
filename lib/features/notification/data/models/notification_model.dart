class NotificationsModel {
  List<NotificationData>? notificationsList;

  Meta? meta;
  bool? success;

  NotificationsModel({this.notificationsList, this.meta, this.success});

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      notificationsList = <NotificationData>[];
      json['data'].forEach((v) {
        notificationsList!.add(NotificationData.fromJson(v));
      });
    }

    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (notificationsList != null) {
      data['data'] = notificationsList!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    data['success'] = success;
    return data;
  }
}

class NotificationData {
  int? id;
  String? title;
  String? body;
  Null readAt;
  String? type;
  String? createdAt;

  NotificationData({
    this.id,
    this.title,
    this.body,
    this.readAt,
    this.type,
    this.createdAt,
  });

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    readAt = json['read_at'];
    type = json['type'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['read_at'] = readAt;
    data['type'] = type;
    data['created_at'] = createdAt;
    return data;
  }
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;

  String? path;
  int? perPage;
  int? to;
  int? total;
  Null message;

  Meta({
    this.currentPage,
    this.from,
    this.lastPage,

    this.path,
    this.perPage,
    this.to,
    this.total,
    this.message,
  });

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];

    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['from'] = from;
    data['last_page'] = lastPage;

    data['path'] = path;
    data['per_page'] = perPage;
    data['to'] = to;
    data['total'] = total;
    data['message'] = message;
    return data;
  }
}

NotificationData dummyNotification = NotificationData(
  id: 1,
  title: "hvbdcs",
  body: "jhdvf",
  type: "sahmd",
  createdAt: "2025-06-03 13:50:10",
);
