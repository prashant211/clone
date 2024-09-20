// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_fieldmodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FormSchema _$FormSchemaFromJson(Map<String, dynamic> json) => FormSchema(
      form: (json['form'] as List<dynamic>)
          .map((e) => Section.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FormSchemaToJson(FormSchema instance) =>
    <String, dynamic>{
      'form': instance.form,
    };

Section _$SectionFromJson(Map<String, dynamic> json) => Section(
      section: SectionDetail.fromJson(json['section'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SectionToJson(Section instance) => <String, dynamic>{
      'section': instance.section,
    };

SectionDetail _$SectionDetailFromJson(Map<String, dynamic> json) =>
    SectionDetail(
      name: json['name'] as String,
      order: (json['order'] as num).toInt(),
      noOfClmn: (json['noOfClmn'] as num).toInt(),
      fields: (json['fields'] as List<dynamic>)
          .map((e) => Field.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SectionDetailToJson(SectionDetail instance) =>
    <String, dynamic>{
      'name': instance.name,
      'order': instance.order,
      'noOfClmn': instance.noOfClmn,
      'fields': instance.fields,
    };

Field _$FieldFromJson(Map<String, dynamic> json) => Field(
      label: json['label'] as String,
      type: json['type'] as String,
      name: json['name'] as String,
      id: json['id'] as String,
      show: json['show'] as bool,
      required: json['required'] as bool,
      order: (json['order'] as num?)?.toInt(),
      className: json['className'] as String?,
      vldGrp: json['vldGrp'] as String?,
    );

Map<String, dynamic> _$FieldToJson(Field instance) => <String, dynamic>{
      'label': instance.label,
      'type': instance.type,
      'name': instance.name,
      'id': instance.id,
      'show': instance.show,
      'required': instance.required,
      'order': instance.order,
      'className': instance.className,
      'vldGrp': instance.vldGrp,
    };
