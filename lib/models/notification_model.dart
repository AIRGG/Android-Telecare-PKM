class NotificationModel {
  int? id;
  String? title;
  String? body;
  String? payload;

  NotificationModel({this.id, this.title, this.body, this.payload});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    payload = json['payload'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    data['payload'] = this.payload;
    return data;
  }
}
