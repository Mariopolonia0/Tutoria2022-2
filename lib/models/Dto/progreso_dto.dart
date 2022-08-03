import 'package:json_annotation/json_annotation.dart';

part 'progreso_dto.g.dart';

@JsonSerializable()
class ProgresoDto {
  String tipoMateria;
  int materiaAprobada;
  int materiaPendiente;
  int materiaRequerida;

  ProgresoDto(this.tipoMateria, this.materiaAprobada, this.materiaPendiente,
      this.materiaRequerida);

  factory ProgresoDto.fromJson(Map<String, dynamic> json) =>
      _$ProgresoDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ProgresoDtoToJson(this);
}
