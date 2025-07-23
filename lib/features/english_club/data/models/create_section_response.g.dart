// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_section_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateSectionResponse _$CreateSectionResponseFromJson(
  Map<String, dynamic> json,
) => CreateSectionResponse(
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : Data.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CreateSectionResponseToJson(
  CreateSectionResponse instance,
) => <String, dynamic>{'message': instance.message, 'data': instance.data};

Data _$DataFromJson(Map<String, dynamic> json) =>
    Data(name: json['name'] as String?, id: (json['id'] as num?)?.toInt());

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
  'name': instance.name,
  'id': instance.id,
};
