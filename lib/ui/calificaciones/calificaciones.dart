import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:projecto_ucne/data/remote/conexion_retrofit.dart';
import 'package:projecto_ucne/models/Dto/cuatrimestre_dto.dart';
import 'package:projecto_ucne/models/Dto/cuatrimestre_indice.dart';
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
        title: const Text('Mis Calificaciones'),
      ),
      body: obtenerVista(context),
    );
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
          return const Expanded(
            child: Center(child: CircularProgressIndicator()),
          );
        }
    }
  }

  obtenerListaCuatrimestre() async {
    final client = RestClient(
      Dio(
        BaseOptions(
          contentType: Headers.jsonContentType,
          validateStatus: (_) => true,
        ),
      ),
    );
    client.getListaCuatrimestre(arguments.estudianteId.toString()).then(
      (value) {
        if (listaYeard == null) {
          setState(
            () {
              listaYeard = value;
              dropdownValue = value[0];
              loading = 1;
            },
          );
        }
      },
    ).catchError(
      (Object obj) {
        setState(
          () {
            loading = 2;
          },
        );
      },
    );
  }

  obtenerCalificaciones() async {
    final client = RestClient(
      Dio(
        BaseOptions(
          contentType: Headers.jsonContentType,
          validateStatus: (_) => true,
        ),
      ),
    );
    client
        .getMateriaCuatrimestre(
            arguments.estudianteId.toString(), dropdownValue)
        .then(
      (value) {
        setState(() {
          listaCuatrimestre = value;
          loading2 = 1;
        });
      },
    ).catchError(
      (Object obj) {
        setState(
          () {
            loading2 = 2;
          },
        );
      },
    );
  }

  Widget obtenerVistaCuatrimestre() {
    //lista para poner la materia por cuatrimestre
    List<CuatrimestreDto> list1 = List.empty(growable: true);
    List<CuatrimestreDto> list2 = List.empty(growable: true);
    List<CuatrimestreDto> list3 = List.empty(growable: true);
    //aqui ordeno la lista por cuatrimestre
    for (var items in listaCuatrimestre!) {
      switch (items.numeroCuatrimestre) {
        case '3':
          list3.add(items);
          break;
        case '2':
          list2.add(items);
          break;
        case '1':
          list1.add(items);
          break;
        default:
      }
    }
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            //si la lista esta vacia no imprimimos el contenedor
            (list3.isNotEmpty) ? pintarCalificaciones('3', list3) : vacio(),
            (list2.isNotEmpty) ? pintarCalificaciones('2', list2) : vacio(),
            (list1.isNotEmpty) ? pintarCalificaciones('1', list1) : vacio()
          ],
        ),
      ),
    );
  }

  Widget vacio() {
    return const SizedBox.shrink();
  }

  Widget pintarCalificaciones(String trimestre, List<CuatrimestreDto> list) {
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
                          Navigator.of(context).pushNamed(
                            '/indice',
                            arguments: CuatrimestreIndice(
                              estudianteId: arguments.estudianteId,
                              cuatrimestreId: list[0].cuatrimestreId,
                            ),
                          );
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
                        ),
                      ),
                    ),
                  ],
                ),
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
                            child: Text(
                              'ASIGNATURA',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
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
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(4),
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return pintarMateria(list[index]);
                      },
                    ),
                  ],
                ),
              ),
            ),
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
          SizedBox(
            width: 180,
            child: Text(cuatrimestreDto.nombreMateria),
          ),
          (int.parse(cuatrimestreDto.nota) < 69)
              ? getNota(
                  cuatrimestreDto.nota,
                  cuatrimestreDto.calificacion,
                  color: const Color(0xFFEC1C24),
                )
              : getNota(cuatrimestreDto.nota, cuatrimestreDto.calificacion),
        ],
      ),
    );
  }

  Widget getNota(String nota, calificacion, {Color? color = Colors.black}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 40, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(nota, style: TextStyle(color: color)),
            SizedBox(
              width: 20,
              child: Text(
                calificacion,
                style: TextStyle(color: color),
              ),
            ),
          ],
        ),
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
                style: const TextStyle(
                    color: Color(0xFF00247D), fontWeight: FontWeight.bold),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(
              () {
                dropdownValue = newValue!;
              },
            );
          },
        ),
      ),
    );
  }
}
