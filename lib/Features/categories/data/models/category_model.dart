import 'package:car_rentting/Features/services/domain/entities/service_entity.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../services/data/models/service_model.dart';

class CategoryModel extends ServiceEntity {
  int? id;
  String? nameAr;
  String? color;
  String? textColor;
  String? nameEn;
  String? descriptionAr;
  String? descriptionEn;
  String? price;
  String? discount;
  String? total;
  String? image;
  int? status;
  String? createdAt;
  String? updatedAt;
  List<Field>? fields;
  List<ServiceEntity>? subCategory;
  List<String>? multiImages;

  CategoryModel(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.multiImages,
      this.descriptionAr,
      this.textColor,
      this.descriptionEn,
      this.image,
      this.color,
      this.total,
      this.price,
      this.discount,
      this.status,
      this.subCategory,
      this.createdAt,
      this.fields,
      this.updatedAt})
      : super(
            catTextColor: HexColor(textColor ?? '#000000'),
            catColor: HexColor(color ?? '#000000'),
            serviceTotal: num.tryParse(total ?? '') == 0 ? null : total,
            serviceMultiImages: multiImages ?? [],
            serviceDiscount: discount,
            servicePrice: price,
            catNameAr: nameAr!,
            catNameEn: nameEn!,
            catDescriptionAr: descriptionAr!,
            catDescriptionEn: descriptionEn!,
            catImage: image!,
            catId: id!,
            serviceField: fields,
            subCategories: subCategory ?? []);

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      nameAr: json['name_ar'],
      nameEn: json['name_en'],
      descriptionAr: json['description_ar'],
      descriptionEn: json['description_en'],
      image: json['image'],
      status: json['status'],
      price: json['price'],
      discount: json['discount'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      fields: json['service_fields'] != null
          ? (json['service_fields'] as List)
              .map((e) => Field.fromJson(e['field']))
              .toList()
          : null,
      multiImages: json['multiImages'] != null && json['multiImages'] is List
          ? (json['multiImages'] as List).map((e) => e.toString()).toList()
          : null,
      subCategory: json['services'] != null
          ? (json['services'] as List)
              .map((e) => CategoryModel.fromJson(e))
              .toList()
          : null,
      total: json['total'],
      color: json['color'],
      textColor: json['text_color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name_ar': nameAr,
      'name_en': nameEn,
      'description_ar': descriptionAr,
      'description_en': descriptionEn,
      'singleImage': image,
      'discount': discount,
      'price': price,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
