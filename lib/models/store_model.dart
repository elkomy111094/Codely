class StoreModel {
  StoreModel({
    required this.id,
    required this.name,
    required this.desc,
    required this.logo,
    required this.cover,
    required this.rate,
    required this.ifFavorite,
    required this.categories,
  });
  late final int id;
  late final String name;
  late final String desc;
  late final String logo;
  late final String cover;
  late final int rate;
  late final bool ifFavorite;
  late final List<Categories> categories;

  StoreModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    logo = json['logo'];
    cover = json['cover'];
    rate = json['rate'];
    ifFavorite = json['if_favorite'];
    categories = List.from(json['categories'])
        .map((e) => Categories.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['desc'] = desc;
    _data['logo'] = logo;
    _data['cover'] = cover;
    _data['rate'] = rate;
    _data['if_favorite'] = ifFavorite;
    _data['categories'] = categories.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Categories {
  Categories({
    required this.id,
    required this.name,
    required this.image,
  });
  late final int id;
  late final String name;
  late final String image;

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['image'] = image;
    return _data;
  }
}

/*
class StoreModel {
  StoreModel({
    required this.id,
    required this.name,
    required this.desc,
    required this.logo,
    required this.cover,
    required this.rate,
    required this.ifFavorite,
    required this.categories,
  });

  late final int id;
  late final String name;
  late final String desc;
  late final String logo;
  late final String cover;
  late final int rate;
  late final bool ifFavorite;
  late final List<dynamic> categories;

  StoreModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    logo = json['logo'];
    cover = json['cover'];
    rate = json['rate'];
    ifFavorite = json['if_favorite'];
    categories = List.castFrom<dynamic, dynamic>(json['categories']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['desc'] = desc;
    _data['logo'] = logo;
    _data['cover'] = cover;
    _data['rate'] = rate;
    _data['if_favorite'] = ifFavorite;
    _data['categories'] = categories;
    return _data;
  }
}
*/
