// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grades_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GradesResponse _$GradesResponseFromJson(Map<String, dynamic> json) =>
    GradesResponse(
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GradesResponseToJson(GradesResponse instance) =>
    <String, dynamic>{'message': instance.message, 'data': instance.data};

Data _$DataFromJson(Map<String, dynamic> json) => Data(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  classes: (json['classes'] as List<dynamic>?)
      ?.map((e) => Classes.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'classes': instance.classes,
};

Classes _$ClassesFromJson(Map<String, dynamic> json) => Classes(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  gradeId: (json['grade_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$ClassesToJson(Classes instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'grade_id': instance.gradeId,
};
