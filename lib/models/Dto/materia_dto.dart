class MateriaDto {
  final String nombreMateria;
  final String dia;
  final String aula;
  final String horaInicio;
  final String horaFinal;

  MateriaDto(
      this.nombreMateria, this.dia, this.aula, this.horaInicio, this.horaFinal);

  factory MateriaDto.fromJson(Map<String, dynamic> json) {
    return MateriaDto(json['nombreMateria'], json['dia'], json['aula'],
        json['horaInicio'], json['horaFinal']);
  }
}
