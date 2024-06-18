class SettingsData {
  SettingsData({
    required this.social,
    required this.info,
    required this.pages,
    required this.paymentMethods,
    required this.introPage,
  });

  late final Social social;
  late final Info info;
  late final List<Pages> pages;
  late final List<PaymentMethods> paymentMethods;
  late final List<dynamic> introPage;

  SettingsData.fromJson(Map<String, dynamic> json) {
    social = Social.fromJson(json['social']);
    info = Info.fromJson(json['info']);
    pages = List.from(json['pages']).map((e) => Pages.fromJson(e)).toList();
    paymentMethods = List.from(json['payment_methods'])
        .map((e) => PaymentMethods.fromJson(e))
        .toList();
    introPage = List.castFrom<dynamic, dynamic>(json['intro_page']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['social'] = social.toJson();
    _data['info'] = info.toJson();
    _data['pages'] = pages.map((e) => e.toJson()).toList();
    _data['payment_methods'] = paymentMethods.map((e) => e.toJson()).toList();
    _data['intro_page'] = introPage;
    return _data;
  }
}

class Social {
  Social({
    required this.facebook,
    required this.twitter,
    required this.instagram,
  });

  late final String facebook;
  late final String twitter;
  late final String instagram;

  Social.fromJson(Map<String, dynamic> json) {
    facebook = json['facebook'];
    twitter = json['twitter'];
    instagram = json['instagram'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['facebook'] = facebook;
    _data['twitter'] = twitter;
    _data['instagram'] = instagram;
    return _data;
  }
}

class Info {
  Info({
    required this.websiteName,
    required this.websiteLogo,
    required this.phone,
    required this.email,
    required this.whatsApp,
  });

  late final String websiteName;
  late final String websiteLogo;
  late final String phone;
  late final String email;
  late final String whatsApp;

  Info.fromJson(Map<String, dynamic> json) {
    websiteName = json['website_name'];
    websiteLogo = json['website_logo'];
    phone = json['phone'];
    email = json['email'];
    whatsApp = json['whats_app'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['website_name'] = websiteName;
    _data['website_logo'] = websiteLogo;
    _data['phone'] = phone;
    _data['email'] = email;
    _data['whats_app'] = whatsApp;
    return _data;
  }
}

class Pages {
  Pages({
    required this.id,
    required this.title,
    required this.value,
  });

  late final int id;
  late final String title;
  late final String value;

  Pages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['value'] = value;
    return _data;
  }
}

class PaymentMethods {
  PaymentMethods({
    required this.name,
    required this.image,
  });

  late final String name;
  late final String image;

  PaymentMethods.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['image'] = image;
    return _data;
  }
}
