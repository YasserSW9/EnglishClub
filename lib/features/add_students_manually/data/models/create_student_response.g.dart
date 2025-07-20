// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_student_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateStudentResponse _$CreateStudentResponseFromJson(
  Map<String, dynamic> json,
) => CreateStudentResponse(
  message: json['message'] as String?,
  data: json['data'] == null
      ? null
      : Data.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CreateStudentResponseToJson(
  CreateStudentResponse instance,
) => <String, dynamic>{'message': instance.message, 'data': instance.data};

Data _$DataFromJson(Map<String, dynamic> json) => Data(
  student: json['student'] == null
      ? null
      : Student.fromJson(json['student'] as Map<String, dynamic>),
  account: json['account'] == null
      ? null
      : Account.fromJson(json['account'] as Map<String, dynamic>),
);

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
  'student': instance.student,
  'account': instance.account,
};

Student _$StudentFromJson(Map<String, dynamic> json) => Student(
  name: json['name'] as String?,
  gClassId: (json['g_class_id'] as num?)?.toInt(),
  borrowLimit: (json['borrow_limit'] as num?)?.toInt(),
  id: (json['id'] as num?)?.toInt(),
  score: (json['score'] as num?)?.toInt(),
  goldenCoins: (json['golden_coins'] as num?)?.toInt(),
  silverCoins: (json['silver_coins'] as num?)?.toInt(),
  bronzeCoins: (json['bronze_coins'] as num?)?.toInt(),
);

Map<String, dynamic> _$StudentToJson(Student instance) => <String, dynamic>{
  'name': instance.name,
  'g_class_id': instance.gClassId,
  'borrow_limit': instance.borrowLimit,
  'id': instance.id,
  'score': instance.score,
  'golden_coins': instance.goldenCoins,
  'silver_coins': instance.silverCoins,
  'bronze_coins': instance.bronzeCoins,
};

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
  username: json['username'] as String?,
  password: json['password'] as String?,
);

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
  'username': instance.username,
  'password': instance.password,
};
