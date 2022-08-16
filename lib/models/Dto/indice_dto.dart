import 'package:json_annotation/json_annotation.dart';

part 'indice_dto.g.dart';

@JsonSerializable()
class IndiceDto {
  final String yeard;
  final String meses;
  final String indicePeriodo;
  final String indiceAcumulado;

  IndiceDto(this.yeard, this.meses, this.indicePeriodo, this.indiceAcumulado);

   factory IndiceDto.fromJson(Map<String, dynamic> json) =>
      _$IndiceDtoFromJson(json);
  Map<String, dynamic> toJson() => _$IndiceDtoToJson(this);
}
  
  
