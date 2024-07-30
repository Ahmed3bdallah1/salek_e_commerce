import 'package:car_rentting/Features/home/domain/entities/ad_entity.dart';

class AdModel extends AdEntity {
  final int id;
  final String image;
  final AdType type;
  final String typeId;
  final int status;
  final String? createdAt;
  final String? updatedAt;

  AdModel({
    required this.id,
    required this.image,
    required this.type,
    required this.typeId,
    required this.status,
    this.createdAt,
    this.updatedAt,
  }) : super(photo: image, navTo: typeId, adType: type);

  factory AdModel.fromJson(Map<String, dynamic> json) {
    return AdModel(
      id: json['id'],
      image: json['image'],
      type:
          AdType.values.firstWhere((element) => element.value == json['type']),
      typeId: json['type_id'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
