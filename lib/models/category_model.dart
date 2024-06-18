class CategoryModel {
  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
  });

  late final int id;
  late final String name;
  late final String image;

  CategoryModel.fromJson(Map<String, dynamic> json) {
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
