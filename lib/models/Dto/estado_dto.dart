import 'dart:ffi';
import 'package:json_annotation/json_annotation.dart';

part 'estado_dto.g.dart';

@JsonSerializable()
class EstadoDto {
  final String descripcion;
  final String fechaRealizado;
  final double transaccion;
  final double estado;

  EstadoDto(
      {required this.descripcion,
      required this.fechaRealizado,
      required this.transaccion,
      required this.estado});

  factory EstadoDto.fromJson(Map<String, dynamic> json) =>
      _$EstadoDtoFromJson(json);
  Map<String, dynamic> toJson() => _$EstadoDtoToJson(this);
}
