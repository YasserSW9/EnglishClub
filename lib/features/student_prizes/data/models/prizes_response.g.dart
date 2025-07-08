// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prizes_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PrizesResponse _$PrizesResponseFromJson(Map<String, dynamic> json) =>
    PrizesResponse(
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : PrizesData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PrizesResponseToJson(PrizesResponse instance) =>
    <String, dynamic>{'message': instance.message, 'data': instance.data};

PrizesData _$PrizesDataFromJson(Map<String, dynamic> json) => PrizesData(
  currentPage: (json['current_page'] as num?)?.toInt(),
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => PrizeItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  firstPageUrl: json['first_page_url'] as String?,
  from: (json['from'] as num?)?.toInt(),
  nextPageUrl: json['next_page_url'] as String?,
  path: json['path'] as String?,
  perPage: (json['per_page'] as num?)?.toInt(),
  prevPageUrl: json['prev_page_url'] as String?,
  to: (json['to'] as num?)?.toInt(),
);

Map<String, dynamic> _$PrizesDataToJson(PrizesData instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'data': instance.data,
      'first_page_url': instance.firstPageUrl,
      'from': instance.from,
      'next_page_url': instance.nextPageUrl,
      'path': instance.path,
      'per_page': instance.perPage,
      'prev_page_url': instance.prevPageUrl,
      'to': instance.to,
    };

PrizeItem _$PrizeItemFromJson(Map<String, dynamic> json) => PrizeItem(
  id: (json['id'] as num?)?.toInt(),
  date: json['date'] as String?,
  collectedAt: json['collected_at'] as String?,
  reason: json['reason'] as String?,
  collected: (json['collected'] as num?)?.toInt(),
  testId: (json['test_id'] as num?)?.toInt(),
  studentId: (json['student_id'] as num?)?.toInt(),
  prizeId: (json['prize_id'] as num?)?.toInt(),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  giveItTo: json['giveItTo'] == null
      ? null
      : GiveItTo.fromJson(json['giveItTo'] as Map<String, dynamic>),
  prize: json['prize'] == null
      ? null
      : Prize.fromJson(json['prize'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PrizeItemToJson(PrizeItem instance) => <String, dynamic>{
  'id': instance.id,
  'date': instance.date,
  'collected_at': instance.collectedAt,
  'reason': instance.reason,
  'collected': instance.collected,
  'test_id': instance.testId,
  'student_id': instance.studentId,
  'prize_id': instance.prizeId,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
  'giveItTo': instance.giveItTo,
  'prize': instance.prize,
};

GiveItTo _$GiveItToFromJson(Map<String, dynamic> json) => GiveItTo(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  score: (json['score'] as num?)?.toInt(),
  goldenCoins: (json['golden_coins'] as num?)?.toInt(),
  silverCoins: (json['silver_coins'] as num?)?.toInt(),
  bronzeCoins: (json['bronze_coins'] as num?)?.toInt(),
  profilePicture: json['profile_picture'] as String?,
  inactive: json['inactive'] as String?,
  borrowLimit: (json['borrow_limit'] as num?)?.toInt(),
  gClassId: (json['g_class_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$GiveItToToJson(GiveItTo instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'score': instance.score,
  'golden_coins': instance.goldenCoins,
  'silver_coins': instance.silverCoins,
  'bronze_coins': instance.bronzeCoins,
  'profile_picture': instance.profilePicture,
  'inactive': instance.inactive,
  'borrow_limit': instance.borrowLimit,
  'g_class_id': instance.gClassId,
};

Prize _$PrizeFromJson(Map<String, dynamic> json) => Prize(
  id: (json['id'] as num?)?.toInt(),
  scorePoints: (json['score_points'] as num?)?.toInt(),
  goldenCoin: (json['golden_coin'] as num?)?.toInt(),
  silverCoin: (json['silver_coin'] as num?)?.toInt(),
  bronzeCoin: (json['bronze_coin'] as num?)?.toInt(),
);

Map<String, dynamic> _$PrizeToJson(Prize instance) => <String, dynamic>{
  'id': instance.id,
  'score_points': instance.scorePoints,
  'golden_coin': instance.goldenCoin,
  'silver_coin': instance.silverCoin,
  'bronze_coin': instance.bronzeCoin,
};
