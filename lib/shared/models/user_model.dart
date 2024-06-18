class UserModel {
  UserModel({
    required this.message,
    required this.errors,
    required this.user,
    required this.token,
  });

  late final String message;
  late final List<dynamic> errors;
  late final UserData user;
  late final String token;

  UserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    errors = List.castFrom<dynamic, dynamic>(json['errors']);
    user = UserData.fromJson(json['data']);
    token = json['api_token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data['message'] = message;
    _data['errors'] = errors;
    _data['data'] = user.toJson();
    _data['api_token'] = token;
    return _data;
  }
}

class UserData {
  UserData({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.avatar,
    required this.subscription,
  });

  late final String? firstName;
  late final String? lastName;
  late final String? email;
  late final String? phone;
  late final String? avatar;
  late final Subscription subscription;

  UserData.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    avatar = json['avatar'];
    subscription = Subscription.fromJson(json['subscription']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    _data['email'] = email;
    _data['phone'] = phone;
    _data['avatar'] = avatar;
    _data['subscription'] = subscription.toJson();
    return _data;
  }
}

class Subscription {
  Subscription({
    required this.status,
    required this.details,
  });
  late final bool status;
  late final Details details;

  Subscription.fromJson(Map<String, dynamic> json){
    status = json['status'];
    details = Details.fromJson(json['details']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['details'] = details.toJson();
    return _data;
  }
}

class Details {
  Details({
    required this.id,
    required this.name,
    required this.start,
    required this.end,
    required this.price,
    required this.paymentStatus,
  });
  late final int id;
  late final String name;
  late final String start;
  late final String end;
  late final int price;
  late final String paymentStatus;

  Details.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    start = json['start'];
    end = json['end'];
    price = json['price'];
    paymentStatus = json['payment_status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['start'] = start;
    _data['end'] = end;
    _data['price'] = price;
    _data['payment_status'] = paymentStatus;
    return _data;
  }
}
