// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conexion_retrofit.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://tutoria2022.azurewebsites.net/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<String> bueno() async {
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final headers = <String, dynamic>{};
    final data = <String, dynamic>{};
    final result = await _dio.fetch<String>(_setStreamType<String>(
        Options(method: 'GET', headers: headers, extra: extra)
            .compose(_dio.options, '',
                queryParameters: queryParameters, data: data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = result.data!;
    return value;
  }

  @override
  Future<List<MateriaDto>> getMateriaHoy(id) async {
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final headers = <String, dynamic>{};
    final data = <String, dynamic>{};
    final result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<MateriaDto>>(
            Options(method: 'GET', headers: headers, extra: extra)
                .compose(_dio.options, 'api/MateriaHoy/${id}',
                    queryParameters: queryParameters, data: data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = result.data!
        .map((dynamic i) => MateriaDto.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<EstadoDto>> getEstados(id) async {
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final headers = <String, dynamic>{};
    final data = <String, dynamic>{};
    final result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<EstadoDto>>(
            Options(method: 'GET', headers: headers, extra: extra)
                .compose(_dio.options, 'api/Transacciones/${id}',
                    queryParameters: queryParameters, data: data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = result.data!
        .map((dynamic i) => EstadoDto.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<PerfilDto> getPerfil(id) async {
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final headers = <String, dynamic>{};
    final data = <String, dynamic>{};
    final result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PerfilDto>(
            Options(method: 'GET', headers: headers, extra: extra)
                .compose(_dio.options, 'api/Estudiantes/${id}',
                    queryParameters: queryParameters, data: data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = PerfilDto.fromJson(result.data!);
    return value;
  }

  @override
  Future<List<ProgresoDto>> getProgreso(id) async {
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final headers = <String, dynamic>{};
    final data = <String, dynamic>{};
    final result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<ProgresoDto>>(
            Options(method: 'GET', headers: headers, extra: extra)
                .compose(_dio.options, 'api/Progreso/${id}',
                    queryParameters: queryParameters, data: data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    var value = result.data!
        .map((dynamic i) => ProgresoDto.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<LoginDto> hacerLogin(usuario, password) async {
    const extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final headers = <String, dynamic>{};
    final data = {'usuario': usuario, 'password': password};
    final result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<LoginDto>(
            Options(method: 'POST', headers: headers, extra: extra)
                .compose(_dio.options, 'api/Login',
                    queryParameters: queryParameters, data:data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = LoginDto.fromJson(result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
