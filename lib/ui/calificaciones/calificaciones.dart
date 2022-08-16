import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:projecto_ucne/data/remote/conexion_retrofit.dart';
import 'package:projecto_ucne/models/Dto/cuatrimestre_dto.dart';
import '../../models/Dto/login_dto.dart';

class Calificaciones extends StatefulWidget {
  const Calificaciones({super.key});

  @override
  State<Calificaciones> createState() => _CalificacionesState();
}

class _CalificacionesState extends State<Calificaciones> {
  final fonmKey = GlobalKey<FormState>();

  int loading = 0;
  int loading2 = 0;

  LoginDto arguments =
      LoginDto(estudianteId: 0, nombreEstudiante: '', matricula: '');

  List<String>? listaYeard;
  List<CuatrimestreDto>? listaCuatrimestre;
  String dropdownValue = "";

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context)!.settings.arguments as LoginDto;
    obtenerListaCuatrimestre();
    obtenerCalificaciones();
    return Scaffold(
        backgroundColor: const Color(0xFF91D8F7),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            surfaceTintColor: Colors.white,
            backgroundColor: const Color(0xFF00247D),
            title: const Text('Mis Calificaciones')),
        body: obtenerVista(context));
  }

  Widget obtenerVista(BuildContext context) {
    switch (loading) {
      case 1:
        {
          return Column(
            children: [selectYear(), obtenerVistaCalificaciones()],
          );
        }
      case 2:
        {
          return const Center(child: Text('Error De Internet'));
        }
      default:
        {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(30.0),
              child: CircularProgressIndicator(),
            ),
          );
        }
    }
  }

  Widget obtenerVistaCalificaciones() {
    switch (loading2) {
      case 1:
        {
          return obtenerVistaCuatrimestre();
        }
      default:
        {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(30.0),
              child: CircularProgressIndicator(),
            ),
          );
        }
    }
  }

  obtenerListaCuatrimestre() async {
    final client = RestClient(Dio(BaseOptions(
      contentType: Headers.jsonContentType,
      validateStatus: (_) => true,
    )));
    client
        .getListaCuatrimestre(arguments.estudianteId.toString())
        .then((value) {
      if (listaYeard == null) {
        setState(() {
          listaYeard = value;
          dropdownValue = value[0];
          loading = 1;
        });
      }
    }).catchError((Object obj) {
      setState(() {
        loading = 2;
      });
    });
  }

  obtenerCalificaciones() async {
    final client = RestClient(Dio(BaseOptions(
      contentType: Headers.jsonContentType,
      validateStatus: (_) => true,
    )));
    client
        .getMateriaCuatrimestre(
            arguments.estudianteId.toString(), dropdownValue)
        .then((value) {
      setState(() {
        listaCuatrimestre = value;
        loading2 = 1;
      });
    }).catchError((Object obj) {
      setState(() {
        loading2 = 2;
      });
    });
  }

  Widget obtenerVistaCuatrimestre() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            pintarCalificaciones('3'),
            pintarCalificaciones('2'),
            pintarCalificaciones('1'),
          ],
        ),
      ),
    );
  }

  Widget pintarCalificaciones(String trimestre) {
    List<CuatrimestreDto> list = List.empty(growable: true);
    for (var items in listaCuatrimestre!) {
      if (items.numeroCuatrimestre == trimestre) {
        list.add(items);
      }
    }
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Color(0xFF00247D),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$trimestre-$dropdownValue',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 40,
                        child: TextButton.icon(
                            onPressed: () {
                              arguments.nombreEstudiante = list[0].cuatrimestreId.toString();
                              Navigator.of(context)
                                  .pushNamed('/indice', arguments: arguments);
                            },
                            icon: const Icon(
                              Icons.bar_chart_outlined,
                              color: Colors.white,
                              size: 25,
                            ),
                            label: const Text(
                              'Ver Indice',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 4),
              child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(
                              width: 180,
                              child: Text('ASIGNATURA',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text('NOTA',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text('CALIFICACIÓN',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(4),
                          itemCount: list.length,
                          itemBuilder: (BuildContext context, int index) {
                            return pintarMateria(list[index]);
                          }),
                    ],
                  )),
            )
          ],
        ));
  }

  Widget pintarMateria(CuatrimestreDto cuatrimestreDto) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 180, child: Text(cuatrimestreDto.nombreMateria)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 40, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(cuatrimestreDto.nota),
                  SizedBox(
                      width: 20, child: Text(cuatrimestreDto.calificacion)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget selectYear() {
    return Container(
      padding: const EdgeInsets.all(4),
      alignment: Alignment.center,
      color: const Color(0xFF00247D),
      child: Container(
        height: 40,
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: DropdownButton(
          value: dropdownValue,
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Color(0xFF00247D),
          ),
          underline: Container(),
          items: listaYeard!.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(color: Color(0xFF00247D),fontWeight: FontWeight.bold),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
          },
        ),
      ),
    );
  }
}