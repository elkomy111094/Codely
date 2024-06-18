extension BoolExtensions on bool? {
  bool get isNullOrFalse => this == null || !this!;

  bool get isNotNullAndTrue => this != null && this!;
}
