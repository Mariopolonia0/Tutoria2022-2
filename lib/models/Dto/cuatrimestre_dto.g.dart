// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cuatrimestre_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CuatrimestreDto _$CuatrimestreDtoFromJson(Map<String, dynamic> json) =>
    CuatrimestreDto(
      json['cuatrimestreId'] as int,
      json['numeroCuatrimestre'] as String,
      json['nombreMateria'] as String,
      json['nota'] as String,
      json['calificacion'] as String,
    );

Map<String, dynamic> _$CuatrimestreDtoToJson(CuatrimestreDto instance) =>
    <String, dynamic>{
      'cuatrimestreId': instance.cuatrimestreId,
      'numeroCuatrimestre': instance.numeroCuatrimestre,
      'nombreMateria': instance.nombreMateria,
      'nota': instance.nota,
      'calificacion': instance.calificacion,
    };
