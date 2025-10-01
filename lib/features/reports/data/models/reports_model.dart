class ReportsResponse {
  final List<Report> data;
  final Links links;
  final Meta meta;
  final bool success;

  ReportsResponse({
    required this.data,
    required this.links,
    required this.meta,
    required this.success,
  });

  factory ReportsResponse.fromJson(Map<String, dynamic> json) {
    return ReportsResponse(
      data:
          (json['data'] as List).map((item) => Report.fromJson(item)).toList(),
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

// Report model
class Report {
  final int id;
  final String uid;
  final String carType;
  final String carModel;
  final String carModelYear;
  final String dateTime;
  final String report;

  Report({
    required this.id,
    required this.uid,
    required this.carType,
    required this.carModel,
    required this.carModelYear,
    required this.dateTime,
    required this.report,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'] ?? 0,
      uid: json['uid'] ?? '',
      carType: json['car_type'] ?? '',
      carModel: json['car_model'] ?? '',
      carModelYear: json['car_model_year'] ?? '',
      dateTime: json['date_time'] ?? '',
      report: json['report'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'car_type': carType,
      'car_model': carModel,
      'car_model_year': carModelYear,
      'date_time': dateTime,
      'report': report,
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

// Dummy report instance
Report dummyReport = Report(
  id: -1,
  uid: '',
  carType: '',
  carModel: '',
  carModelYear: '',
  dateTime: "2025-06-20 19:40:00",
  report: '',
);
