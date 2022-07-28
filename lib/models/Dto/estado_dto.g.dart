// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'estado_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EstadoDto _$EstadoDtoFromJson(Map<String, dynamic> json) => EstadoDto(
      descripcion: json['descripcion'] as String,
      fechaRealizado: json['fechaRealizado'] as String,
      transaccion: json['transaccion'] as double,
      estado: json['estado'] as double,
    );

Map<String, dynamic> _$EstadoDtoToJson(EstadoDto instance) => <String, dynamic>{
      'descripcion': instance.descripcion,
      'fechaRealizado': instance.fechaRealizado,
      'transaccion': instance.transaccion,
      'estado': instance.estado,
    };
