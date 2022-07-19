// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginDto _$LoginDtoFromJson(Map<String, dynamic> json) => LoginDto(
      estudianteId: json['estudianteId'] as int,
      nombreEstudiante: json['nombreEstudiante'] as String,
      matricula: json['matricula'] as String,
    );

Map<String, dynamic> _$LoginDtoToJson(LoginDto instance) => <String, dynamic>{
      'estudianteId': instance.estudianteId,
      'nombreEstudiante': instance.nombreEstudiante,
      'matricula': instance.matricula,
    };
