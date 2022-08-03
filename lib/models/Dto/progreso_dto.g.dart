// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progreso_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProgresoDto _$ProgresoDtoFromJson(Map<String, dynamic> json) => ProgresoDto(
      json['tipoMateria'] as String,
      json['materiaAprobada'] as int,
      json['materiaPendiente'] as int,
      json['materiaRequerida'] as int,
    );

Map<String, dynamic> _$ProgresoDtoToJson(ProgresoDto instance) =>
    <String, dynamic>{
      'tipoMateria': instance.tipoMateria,
      'materiaAprobada': instance.materiaAprobada,
      'materiaPendiente': instance.materiaPendiente,
      'materiaRequerida': instance.materiaRequerida,
    };
