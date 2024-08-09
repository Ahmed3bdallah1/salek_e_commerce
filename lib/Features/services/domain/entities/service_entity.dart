import 'dart:ui';

import '../../data/models/service_model.dart';

class ServiceEntity {
  final List<Field>? serviceField;
  final String? servicePrice;
  final String? serviceTotal;
  final String catNameAr;
  final String? attachmentUrl;
  final Color catColor;
   final Color catTextColor;
  final int catId;
  final String catNameEn;
  final String catDescriptionAr;
  final String catDescriptionEn;
  final String catImage;
  final List<ServiceEntity> subCategories;
  final List<String> serviceMultiImages;
  final String? serviceDiscount;

  ServiceEntity({
    required this.serviceTotal,
     required this.catColor,
    required this.catTextColor,
    required this.serviceField,
    required this.serviceMultiImages,
    required this.servicePrice,
    required this.attachmentUrl,
    required this.serviceDiscount,
    required this.catNameAr,
    required this.catNameEn,
    required this.catDescriptionAr,
    required this.catDescriptionEn,
    required this.catImage,
    required this.catId,
    required this.subCategories,
  });

  factory ServiceEntity.fromJson(Map<String, dynamic> json) {
     return ServiceEntity(
       serviceField: (json['serviceField'] as List<dynamic>?)
          ?.map((item) => Field.fromJson(item))
          .toList(),
      servicePrice: json['servicePrice'],
      attachmentUrl: json['attachmentUrl'],
      serviceTotal: json['serviceTotal'],
      catNameAr: json['catNameAr'],
      catColor: Color(int.parse(json['catColor'], radix: 16)),
      catTextColor: Color(int.parse(json['catTextColor'], radix: 16)),
      catId: json['catId'],
      catNameEn: json['catNameEn'],
      catDescriptionAr: json['catDescriptionAr'],
      catDescriptionEn: json['catDescriptionEn'],
      catImage: json['catImage'],
      subCategories: (json['subCategories'] as List<dynamic>)
          .map((item) => ServiceEntity.fromJson(item))
          .toList(),
      serviceMultiImages: List<String>.from(json['serviceMultiImages']),
      serviceDiscount: json['serviceDiscount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'serviceField': serviceField?.map((item) => item.toJson()).toList(),
      'servicePrice': servicePrice,
      'serviceTotal': serviceTotal,
      'catNameAr': catNameAr,
      'catColor': catColor.value.toRadixString(16),
      'catTextColor': catTextColor.value.toRadixString(16),
      'catId': catId,
      'catNameEn': catNameEn,
      'catDescriptionAr': catDescriptionAr,
      'catDescriptionEn': catDescriptionEn,
      'catImage': catImage,
      'subCategories': subCategories.map((item) => item.toJson()).toList(),
      'serviceMultiImages': serviceMultiImages,
      'serviceDiscount': serviceDiscount,
    };
  }
}
