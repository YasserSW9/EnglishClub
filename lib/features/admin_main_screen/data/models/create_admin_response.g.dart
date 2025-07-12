// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_admin_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateAdminResponse _$CreateAdminResponseFromJson(Map<String, dynamic> json) =>
    CreateAdminResponse(
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateAdminResponseToJson(
  CreateAdminResponse instance,
) => <String, dynamic>{'message': instance.message, 'data': instance.data};

Data _$DataFromJson(Map<String, dynamic> json) => Data(
  account: json['account'] == null
      ? null
      : Account.fromJson(json['account'] as Map<String, dynamic>),
);

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
  'account': instance.account,
};

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
  username: json['username'] as String?,
  password: json['password'] as String?,
);

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
  'username': instance.username,
  'password': instance.password,
};
