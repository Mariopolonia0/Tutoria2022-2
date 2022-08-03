// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'perfil_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PerfilDto _$PerfilDtoFromJson(Map<String, dynamic> json) => PerfilDto(
      json['nombrecompleto'] as String,
      json['carrera'] as String,
      json['celular'] as String,
      json['correo'] as String,
      json['nacionalidad'] as String,
      json['tutor'] as String,
    );

Map<String, dynamic> _$PerfilDtoToJson(PerfilDto instance) => <String, dynamic>{
      'nombrecompleto': instance.nombrecompleto,
      'carrera': instance.carrera,
      'correo': instance.correo,
      'nacionalidad': instance.nacionalidad,
      'tutor': instance.tutor,
      'celular': instance.celular,
    };
