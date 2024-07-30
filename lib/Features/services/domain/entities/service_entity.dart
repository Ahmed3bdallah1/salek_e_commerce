import 'dart:ui';

import '../../data/models/service_model.dart';

class ServiceEntity {
  final List<Field>? serviceField;
  final String? servicePrice;
  final String? serviceTotal;
  final String catNameAr;
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
    required this.serviceDiscount,
    required this.catNameAr,
    required this.catNameEn,
    required this.catDescriptionAr,
    required this.catDescriptionEn,
    required this.catImage,
    required this.catId,
    required this.subCategories,
  });
}
