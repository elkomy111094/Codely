class RateModel {
  RateModel({
    required this.id,
    required this.user,
    required this.rate,
    required this.message,
    required this.createdAt,
  });
  late final int id;
  late final User user;
  late final int rate;
  late final String message;
  late final String createdAt;

  RateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = User.fromJson(json['user']);
    rate = json['rate'];
    message = json['message'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user'] = user.toJson();
    _data['rate'] = rate;
    _data['message'] = message;
    _data['created_at'] = createdAt;
    return _data;
  }
}

class User {
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });
  late final int id;
  late final String firstName;
  late final String lastName;
  late final String avatar;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['avatar'] = avatar;
    return _data;
  }
}
