class SettingItemModel {
  int? id;
  String? nameAr;
  String? nameEn;
  String? valueAr;
  String? valueEn;
  String? createdAt;
  String? updatedAt;

  SettingItemModel({
    this.id,
    this.nameAr,
    this.nameEn,
    this.valueAr,
    this.valueEn,
    this.createdAt,
    this.updatedAt,
  });

  factory SettingItemModel.fromJson(Map<String, dynamic> json) =>
      SettingItemModel(
        id: json["id"],
        nameAr: json["name_ar"],
        nameEn: json["name_en"],
        valueAr: json["value_ar"],
        valueEn: json["value_en"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_ar": nameAr,
        "name_en": nameEn,
        "value_ar": valueAr,
        "value_en": valueEn,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
