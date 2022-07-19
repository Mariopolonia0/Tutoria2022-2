import 'package:projecto_ucne/models/Dto/materia_dto.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:projecto_ucne/models/Dto/login_dto.dart';

part 'conexion_retrofit.g.dart';

@RestApi(baseUrl: "https://tutoria2022.azurewebsites.net/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("")
  Future<String> bueno();

  @POST("api/Login")
  Future<LoginDto> hacerLogin(
      @Field("usuario") usuario, @Field("password") password);

  @GET("api/MateriaHoy/{id}")
  Future<List<MateriaDto>> getMateriaHoy(@Path("id") String id);
  
}
