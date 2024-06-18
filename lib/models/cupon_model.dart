class CuponModel {
  CuponModel({
    required this.id,
    required this.name,
    required this.desc,
    required this.code,
    required this.expire,
    required this.store,
  });
  late final int id;
  late final String name;
  late final String desc;
  late final String code;
  late final String expire;
  late final Store store;

  CuponModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    code = json['code'];
    expire = json['expire'];
    store = Store.fromJson(json['store']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['desc'] = desc;
    _data['code'] = code;
    _data['expire'] = expire;
    _data['store'] = store.toJson();
    return _data;
  }
}

class Store {
  Store({
    required this.name,
    required this.logo,
  });
  late final String name;
  late final String logo;

  Store.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['logo'] = logo;
    return _data;
  }
}
