class NotificationModel {
  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.modelId,
  });
  late final int id;
  late final String title;
  late final String message;
  late final String type;
  late final int modelId;

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
    type = json['type'];
    modelId = json['model_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['message'] = message;
    _data['type'] = type;
    _data['model_id'] = modelId;
    return _data;
  }
}
