// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      message: json['message'] as String?,
      data: json['userData'] == null
          ? null
          : Data.fromJson(json['userData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{'message': instance.message, 'userData': instance.data};

Data _$DataFromJson(Map<String, dynamic> json) =>
    Data(token: json['token'] as String?, type: json['type'] as String?);

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
  'token': instance.token,
  'type': instance.type,
};
