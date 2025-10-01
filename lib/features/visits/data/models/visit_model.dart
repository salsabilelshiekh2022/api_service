
class VisitsResponse {
  final List<Visit> data;
  final Links links;
  final Meta meta;
  final bool success;

  VisitsResponse({
    required this.data,
    required this.links,
    required this.meta,
    required this.success,
  });

  factory VisitsResponse.fromJson(Map<String, dynamic> json) {
    return VisitsResponse(
      data: (json['data'] as List)
          .map((item) => Visit.fromJson(item))
          .toList(),
      links: Links.fromJson(json['links']),
      meta: Meta.fromJson(json['meta']),
      success: json['success'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((item) => item.toJson()).toList(),
      'links': links.toJson(),
      'meta': meta.toJson(),
      'success': success,
    };
  }
}

// Visit model
class Visit {
  final int id;
  final String uid;
  final String service;
  final String user;
  final String carType;
  final String carModel;
  final String dateTime;
  final String notes;
  final String status;
  final String statusToCheck;
  final String carModelYear;

  Visit({
    required this.id,
    required this.uid,
    required this.user,
    required this.carType,
    required this.carModel,
    required this.dateTime,
    required this.notes,
    required this.status,
    required this.statusToCheck,
    required this.service,
    required this.carModelYear
  });

  factory Visit.fromJson(Map<String, dynamic> json) {
    return Visit(
      id: json['id'] ?? 0,
      uid: json['uid'] ?? '',
      user: json['user'] ?? '',
      carType: json['car_type'] ?? '',
      carModel: json['car_model'] ?? '',
      dateTime: json['date_time'] ?? '',
      notes: json['notes'] ?? '',
      status: json['status'] ?? '',
      statusToCheck: json['status_to_check'] ?? '',
      service: json['service'] ?? '',
      carModelYear: json['car_model_year'] ?? '',
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'user': user,
      'car_type': carType,
      'car_model': carModel,
      'date_time': dateTime,
      'notes': notes,
      'status': status,
      'status_to_check': statusToCheck,
      'service': service,
      'car_model_year': carModelYear
    };
  }
}

// Links model for pagination
class Links {
  final String? first;
  final String? last;
  final String? prev;
  final String? next;

  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      first: json['first'],
      last: json['last'],
      prev: json['prev'],
      next: json['next'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first': first,
      'last': last,
      'prev': prev,
      'next': next,
    };
  }
}

// Meta model for pagination info
class Meta {
  final int currentPage;
  final int? from;
  final int lastPage;
  final List<MetaLink> links;
  final String path;
  final int perPage;
  final int? to;
  final int total;
  final String? message;

  Meta({
    required this.currentPage,
    this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    this.to,
    required this.total,
    this.message,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      currentPage: json['current_page'] ?? 1,
      from: json['from'],
      lastPage: json['last_page'] ?? 1,
      links: (json['links'] as List)
          .map((item) => MetaLink.fromJson(item))
          .toList(),
      path: json['path'] ?? '',
      perPage: json['per_page'] ?? 15,
      to: json['to'],
      total: json['total'] ?? 0,
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'from': from,
      'last_page': lastPage,
      'links': links.map((item) => item.toJson()).toList(),
      'path': path,
      'per_page': perPage,
      'to': to,
      'total': total,
      'message': message,
    };
  }
}

// MetaLink model for pagination links
class MetaLink {
  final String? url;
  final String label;
  final bool active;

  MetaLink({
    this.url,
    required this.label,
    required this.active,
  });

  factory MetaLink.fromJson(Map<String, dynamic> json) {
    return MetaLink(
      url: json['url'],
      label: json['label'] ?? '',
      active: json['active'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'label': label,
      'active': active,
    };
  }
}


  Visit  dummyVisit =Visit(id: -1, uid: '', user: '', carType: '', carModel: '', dateTime: "2025-06-20 19:40:00", notes: '', status: '', statusToCheck: '', service: '', carModelYear: ''); // dummyVisit 
