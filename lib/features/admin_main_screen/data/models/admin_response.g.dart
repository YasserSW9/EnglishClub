// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminResponse _$AdminResponseFromJson(Map<String, dynamic> json) =>
    AdminResponse(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      superField: (json['super'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AdminResponseToJson(AdminResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'super': instance.superField,
    };
