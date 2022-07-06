class LoginDto {
  final int estudianteId;
  final String nombreEstudiante;
  final String matricula;

  LoginDto({required this.estudianteId, required this.nombreEstudiante, required this.matricula});

  factory LoginDto.fromJson(Map<String, dynamic> json) {
    return LoginDto(
      estudianteId: json['estudianteId'],
      nombreEstudiante: json['nombreEstudiante'],
      matricula: json['matricula'],
    );
  }
}
