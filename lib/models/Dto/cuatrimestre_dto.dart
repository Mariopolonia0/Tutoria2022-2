import 'package:json_annotation/json_annotation.dart';

part 'cuatrimestre_dto.g.dart';

@JsonSerializable()
class CuatrimestreDto {
  final int cuatrimestreId;
  final String numeroCuatrimestre;
  final String nombreMateria;
  final String nota;
  final String calificacion;

  CuatrimestreDto(this.cuatrimestreId, this.numeroCuatrimestre,
      this.nombreMateria, this.nota, this.calificacion);

  factory CuatrimestreDto.fromJson(Map<String, dynamic> json) =>
      _$CuatrimestreDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CuatrimestreDtoToJson(this);
}
