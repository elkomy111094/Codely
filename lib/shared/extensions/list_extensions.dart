extension ListExtensions on List? {
  bool get isNotNullNorEmpty => this?.isNotEmpty ?? false;

  bool get isNotNullAndMoreThan1 => isNotNullNorEmpty && this!.length > 1;
}
