import 'package:projecto_ucne/models/Dto/cuatrimestre_dto.dart';
import 'package:projecto_ucne/models/Dto/indice_dto.dart';
import 'package:projecto_ucne/models/Dto/materia_dto.dart';
import 'package:projecto_ucne/models/Dto/perfil_dto.dart';
import 'package:projecto_ucne/models/Dto/progreso_dto.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:projecto_ucne/models/Dto/login_dto.dart';
import '../../models/Dto/estado_dto.dart';

part 'conexion_retrofit.g.dart';

@RestApi(baseUrl: "https://tutoria2022.azurewebsites.net/")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("api/MateriaHoy/{id}")
  Future<List<MateriaDto>> getMateriaHoy(@Path("id") String id);

  @GET("api/Transacciones/{id}")
  Future<List<EstadoDto>> getEstados(@Path("id") String id);

  @GET("api/Estudiantes/{id}")
  Future<PerfilDto> getPerfil(@Path("id") String id);

  @GET("api/Cuatrimestre/{id}")
  Future<List<String>> getListaCuatrimestre(@Path("id") String id);

  @GET("api/Cuatrimestre/{id}/{yeard}")
  Future<List<CuatrimestreDto>> getMateriaCuatrimestre(
      @Path("id") String id, @Path("yeard") String yeard);

  @GET("api/Indice/{id}/{cuatrimestreId}")
  Future<IndiceDto> getIndice(
      @Path("id") String id, @Path("cuatrimestreId") String cuatrimestreId);

  @GET("api/Progreso/{id}")
  Future<List<ProgresoDto>> getProgreso(@Path("id") String id);

  @POST("api/Login")
  Future<LoginDto> hacerLogin(
      @Field("usuario") usuario, @Field("password") password);
}
