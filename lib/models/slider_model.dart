class SliderMModel {
  SliderMModel({
    required this.name,
    required this.image,
  });

  late final String name;
  late final String image;

  SliderMModel.fromJson(Map<String, dynamic> json) {
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
