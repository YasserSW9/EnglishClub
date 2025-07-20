// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_student_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateStudentRequestBody _$CreateStudentRequestBodyFromJson(
  Map<String, dynamic> json,
) => CreateStudentRequestBody(
  name: json['name'] as String?,
  gClassId: (json['g_class_id'] as num?)?.toInt(),
  score: (json['score'] as num?)?.toInt(),
  goldenCoins: (json['golden_coins'] as num?)?.toInt(),
  silverCoins: (json['silver_coins'] as num?)?.toInt(),
  bronzeCoins: (json['bronze_coins'] as num?)?.toInt(),
  borrowLimit: (json['borrow_limit'] as num?)?.toInt(),
  progresses: (json['progresses'] as List<dynamic>?)
      ?.map((e) => e as Map<String, dynamic>)
      .toList(),
);

Map<String, dynamic> _$CreateStudentRequestBodyToJson(
  CreateStudentRequestBody instance,
) => <String, dynamic>{
  'name': instance.name,
  'g_class_id': instance.gClassId,
  'score': instance.score,
  'golden_coins': instance.goldenCoins,
  'silver_coins': instance.silverCoins,
  'bronze_coins': instance.bronzeCoins,
  'borrow_limit': instance.borrowLimit,
  'progresses': instance.progresses,
};
