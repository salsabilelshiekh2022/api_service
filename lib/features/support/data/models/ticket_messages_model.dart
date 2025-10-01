class TicketMessages {
  Data? data;
  bool? success;
  Meta? meta;

  TicketMessages({this.data, this.success, this.meta});

  TicketMessages.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    success = json['success'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['success'] = success;
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? uid;
  String? subject;
  String? status;
  String? createdAt;
  String? image;
  List<Messages>? messages;

  Data(
      {this.id,
      this.uid,
      this.subject,
      this.status,
      this.createdAt,
      this.image,
      this.messages});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    subject = json['subject'];
    status = json['status'];
    createdAt = json['created_at'];
    image = json['image'];
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['uid'] = uid;
    data['subject'] = subject;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['image'] = image;
    if (messages != null) {
      data['messages'] = messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Messages {
  int? id;
  String? sender;
  String? content;

  Messages({this.id, this.sender, this.content});

  Messages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sender = json['sender'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sender'] = sender;
    data['content'] = content;
    return data;
  }
}

class Meta {
  String? message;

  Meta({this.message});

  Meta.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    return data;
  }
}