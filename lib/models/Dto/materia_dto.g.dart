// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'materia_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MateriaDto _$MateriaDtoFromJson(Map<String, dynamic> json) => MateriaDto(
      json['nombreMateria'] as String,
      json['dia'] as String,
      json['aula'] as String,
      json['horaInicio'] as String,
      json['horaFinal'] as String,
    );

Map<String, dynamic> _$MateriaDtoToJson(MateriaDto instance) =>
    <String, dynamic>{
      'nombreMateria': instance.nombreMateria,
      'dia': instance.dia,
      'aula': instance.aula,
      'horaInicio': instance.horaInicio,
      'horaFinal': instance.horaFinal,
    };
