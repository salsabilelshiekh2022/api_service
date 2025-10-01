class TicketsModel {
  List<Ticket>? tickets;
  Links? links;
  Meta? meta;
  bool? success;

  TicketsModel({this.tickets, this.links, this.meta, this.success});

  TicketsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      tickets = <Ticket>[];
      json['data'].forEach((v) {
        tickets!.add(Ticket.fromJson(v));
      });
    }
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (tickets != null) {
      data['data'] = tickets!.map((v) => v.toJson()).toList();
    }
    if (links != null) {
      data['links'] = links!.toJson();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    data['success'] = success;
    return data;
  }
}

class Ticket {
  int? id;
  String? uid;
  String? subject;
  String? status;
  String? createdAt;
  String? category;

  Ticket({
    this.id,
    this.uid,
    this.subject,
    this.status,
    this.createdAt,
    this.category,
  });

  Ticket.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    subject = json['subject'];
    status = json['status'];
    createdAt = json['created_at'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['subject'] = subject;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['category'] = category;
    return data;
  }
}

class Links {
  String? first;
  String? last;
  String? prev;
  String? next;

  Links({this.first, this.last, this.prev, this.next});

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    prev = json['prev'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first'] = first;
    data['last'] = last;
    data['prev'] = prev;
    data['next'] = next;
    return data;
  }
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  List<Links>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;
  String? message;

  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
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
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
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
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['path'] = path;
    data['per_page'] = perPage;
    data['to'] = to;
    data['total'] = total;
    data['message'] = message;
    return data;
  }
}

Ticket dummyTicket = Ticket(
  id: -1,
  uid: "",
  subject: "",
  status: "open",
  createdAt: "2025-02-04",
  category: "",
);
