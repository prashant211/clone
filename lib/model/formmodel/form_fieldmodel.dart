// models.dart
import 'package:json_annotation/json_annotation.dart';

part 'form_fieldmodel.g.dart';
@JsonSerializable()
class FormSchema {
  final List<Section> form;

  FormSchema({required this.form});

  factory FormSchema.fromJson(Map<String, dynamic> json) => _$FormSchemaFromJson(json);
  Map<String, dynamic> toJson() => _$FormSchemaToJson(this);
}

@JsonSerializable()
class Section {
  final SectionDetail section;

  Section({required this.section});

  factory Section.fromJson(Map<String, dynamic> json) => _$SectionFromJson(json);
  Map<String, dynamic> toJson() => _$SectionToJson(this);
}

@JsonSerializable()
class SectionDetail {
  final String name;
  final int order;
  final int noOfClmn;
  final List<Field> fields;

  SectionDetail({
    required this.name,
    required this.order,
    required this.noOfClmn,
    required this.fields,
  });

  factory SectionDetail.fromJson(Map<String, dynamic> json) => _$SectionDetailFromJson(json);
  Map<String, dynamic> toJson() => _$SectionDetailToJson(this);
}

@JsonSerializable()
class Field {
  final String label;
  final String type;
  final String name;
  final String id;
  final bool show;
  final bool required;
  final int? order;
  final String? className;
  final String? vldGrp;

  Field({
    required this.label,
    required this.type,
    required this.name,
    required this.id,
    required this.show,
    required this.required,
    this.order,
    this.className,
    this.vldGrp,
  });

  factory Field.fromJson(Map<String, dynamic> json) => _$FieldFromJson(json);
  Map<String, dynamic> toJson() => _$FieldToJson(this);
}
