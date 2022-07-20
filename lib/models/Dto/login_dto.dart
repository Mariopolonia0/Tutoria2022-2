import 'package:json_annotation/json_annotation.dart';

part 'login_dto.g.dart';

@JsonSerializable()
class LoginDto {
  @JsonKey(name: 'estudianteId')
  final int estudianteId;
  @JsonKey(name: 'nombreEstudiante')
  String nombreEstudiante;
  @JsonKey(name: 'matricula')
  final String matricula;

  LoginDto(
      {required this.estudianteId,
      required this.nombreEstudiante,
      required this.matricula});

  setnombreEstudiante(String value) {
    nombreEstudiante = value;
  }    

  factory LoginDto.fromJson(Map<String, dynamic> json) => _$LoginDtoFromJson(json);
  Map<String, dynamic> toJson() => _$LoginDtoToJson(this);
}
