class AdEntity {
  final String photo;
  final String navTo;
  final AdType adType;

  AdEntity({
    required this.photo,
    required this.navTo,
    this.adType = AdType.none,
  });
}

enum AdType {
  none(0),
  category(1),
  service(2),
  link(3);

  final int value;

  const AdType(this.value);
}
