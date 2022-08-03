import 'package:json_annotation/json_annotation.dart';

part 'materia_dto.g.dart';

@JsonSerializable()
class MateriaDto {
  String nombreMateria;
  String dia;
  String aula;
  String horaInicio;
  String horaFinal;

  MateriaDto(
      this.nombreMateria, this.dia, this.aula, this.horaInicio, this.horaFinal);

  factory MateriaDto.fromJson(Map<String, dynamic> json) =>
      _$MateriaDtoFromJson(json);
  Map<String, dynamic> toJson() => _$MateriaDtoToJson(this);
}
