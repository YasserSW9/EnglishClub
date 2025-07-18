// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_grade_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditGradeResponse _$EditGradeResponseFromJson(Map<String, dynamic> json) =>
    EditGradeResponse(
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EditGradeResponseToJson(EditGradeResponse instance) =>
    <String, dynamic>{'message': instance.message, 'data': instance.data};

Data _$DataFromJson(Map<String, dynamic> json) =>
    Data(id: (json['id'] as num?)?.toInt(), name: json['name'] as String?);

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
};
