import 'package:json_annotation/json_annotation.dart';

part 'perfil_dto.g.dart';

@JsonSerializable()
class PerfilDto {
  String nombrecompleto;
  String carrera;
  String correo;
  String nacionalidad;
  String tutor;
  String celular;

  PerfilDto(this.nombrecompleto, this.carrera, this.celular, this.correo,
      this.nacionalidad, this.tutor);

  factory PerfilDto.fromJson(Map<String, dynamic> json) =>
      _$PerfilDtoFromJson(json);
  Map<String, dynamic> toJson() => _$PerfilDtoToJson(this);
}
