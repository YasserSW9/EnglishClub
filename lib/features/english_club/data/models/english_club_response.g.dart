// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'english_club_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnglishClubResponse _$EnglishClubResponseFromJson(Map<String, dynamic> json) =>
    EnglishClubResponse(
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ClubData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EnglishClubResponseToJson(
  EnglishClubResponse instance,
) => <String, dynamic>{'message': instance.message, 'data': instance.data};

ClubData _$ClubDataFromJson(Map<String, dynamic> json) => ClubData(
  sectionId: (json['section_id'] as num?)?.toInt(),
  sectionName: json['section_name'] as String?,
  availableVocabularyTests: json['availableVocabularyTests'],
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => ClubSubData.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ClubDataToJson(ClubData instance) => <String, dynamic>{
  'section_id': instance.sectionId,
  'section_name': instance.sectionName,
  'availableVocabularyTests': instance.availableVocabularyTests,
  'data': instance.data,
};

ClubSubData _$ClubSubDataFromJson(Map<String, dynamic> json) => ClubSubData(
  name: json['name'] as String?,
  levelId: (json['level_id'] as num?)?.toInt(),
  subLevelId: (json['sub_level_id'] as num?)?.toInt(),
  indexLevel: (json['indexLevel'] as num?)?.toInt(),
  indexSubLevel: (json['indexSubLevel'] as num?)?.toInt(),
  storiesCount: (json['stories_count'] as num?)?.toInt(),
  sectionId: (json['section_id'] as num?)?.toInt(),
  status: json['status'],
  progress: json['progress'],
  stories: (json['stories'] as List<dynamic>?)
      ?.map((e) => Stories.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ClubSubDataToJson(ClubSubData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'level_id': instance.levelId,
      'sub_level_id': instance.subLevelId,
      'indexLevel': instance.indexLevel,
      'indexSubLevel': instance.indexSubLevel,
      'stories_count': instance.storiesCount,
      'section_id': instance.sectionId,
      'status': instance.status,
      'progress': instance.progress,
      'stories': instance.stories,
    };

Stories _$StoriesFromJson(Map<String, dynamic> json) => Stories(
  id: (json['id'] as num?)?.toInt(),
  qrCode: json['qrCode'] as String?,
  title: json['title'] as String?,
  blurb: json['blurb'],
  allowedBorrowDays: (json['allowed_borrow_days'] as num?)?.toInt(),
  quantity: (json['quantity'] as num?)?.toInt(),
  coverUrl: json['cover_url'] as String?,
  subLevelId: (json['sub_level_id'] as num?)?.toInt(),
  testId: (json['test_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$StoriesToJson(Stories instance) => <String, dynamic>{
  'id': instance.id,
  'qrCode': instance.qrCode,
  'title': instance.title,
  'blurb': instance.blurb,
  'allowed_borrow_days': instance.allowedBorrowDays,
  'quantity': instance.quantity,
  'cover_url': instance.coverUrl,
  'sub_level_id': instance.subLevelId,
  'test_id': instance.testId,
};
