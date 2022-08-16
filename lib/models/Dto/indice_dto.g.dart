// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'indice_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IndiceDto _$IndiceDtoFromJson(Map<String, dynamic> json) => IndiceDto(
      json['yeard'] as String,
      json['meses'] as String,
      json['indicePeriodo'] as String,
      json['indiceAcumulado'] as String,
    );

Map<String, dynamic> _$IndiceDtoToJson(IndiceDto instance) => <String, dynamic>{
      'yeard': instance.yeard,
      'meses': instance.meses,
      'indicePeriodo': instance.indicePeriodo,
      'indiceAcumulado': instance.indiceAcumulado,
    };
