enum FieldsType {
  text,
  number,
  image,
  select,
  map,
  date,
  dateAndTime;

  int get fieldId => index + 1;
}

class Field {
  int? id;
  String? name;
  FieldsType? type;
  int? typeValidation;
  String? value;
  String? createdAt;
  String? updatedAt;
  List<FieldOptions>? fieldOptions;

  Field(
      {this.id,
      this.name,
      this.type,
      this.typeValidation,
      this.createdAt,
      this.updatedAt,
      this.value,
      this.fieldOptions});

  Field.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = FieldsType.values
        .firstWhere((element) => element.fieldId == json['type']);
    typeValidation = json['type_validation'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    value = json['value'];
    if (json['field_options'] != null) {
      fieldOptions = <FieldOptions>[];
      json['field_options'].forEach((v) {
        fieldOptions!.add(FieldOptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['type'] = type;
    data['type_validation'] = typeValidation;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['value'] = value;
    if (fieldOptions != null) {
      data['field_options'] = fieldOptions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FieldOptions {
  int? id;
  int? fieldId;
  String? option;
  String? optionEn;
  String? createdAt;
  String? updatedAt;

  FieldOptions(
      {this.id, this.fieldId, this.option, this.createdAt, this.updatedAt});

  FieldOptions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fieldId = json['field_id'];
    option = json['option'];
    optionEn = json['option_en'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['field_id'] = fieldId;
    data['option'] = option;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
