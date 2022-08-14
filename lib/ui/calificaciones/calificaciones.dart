import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:projecto_ucne/data/remote/conexion_retrofit.dart';
import '../../models/Dto/login_dto.dart';

class Calificaciones extends StatefulWidget {
  const Calificaciones({super.key});

  @override
  State<Calificaciones> createState() => _CalificacionesState();
}

class _CalificacionesState extends State<Calificaciones> {
  final fonmKey = GlobalKey<FormState>();

  int loading = 1;

  LoginDto arguments =
      LoginDto(estudianteId: 0, nombreEstudiante: '', matricula: '');

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context)!.settings.arguments as LoginDto;
    obtenerCalificaciones();
    return Scaffold(
        backgroundColor: const Color(0xFF91D8F7),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            surfaceTintColor: Colors.white,
            backgroundColor: const Color(0xFF00247D),
            title: const Text('Mis Calificaciones')),
        body: Column(
          children: [
            selectYear(),
            obtenerVista(context),
          ],
        ));
  }

  obtenerCalificaciones() async {
    final client = RestClient(Dio(BaseOptions(
      contentType: Headers.jsonContentType,
      validateStatus: (_) => true,
    )));
    client.getProgreso('1').then((value) {
      //_progresos = value;
      setState(() {
        loading = 1;
      });
    }).catchError((Object obj) {
      setState(() {
        loading = 2;
      });
    });
  }

  String dropdownValue = '2018';
  Widget selectYear() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(12),
      color: const Color(0xFF00247D),
      child: Center(
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: DropdownButton(
                value: dropdownValue,
                items: <String>['2021', '2020', '2019', '2018']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
              ),
            ),
            Container(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child:const Icon(Icons.search_rounded)),
          ],
        ),
      ),
    );
  }

  Widget obtenerVista(BuildContext context) {
    switch (loading) {
      case 1:
        {
          return vista();
        }
      case 2:
        {
          return const Text('Error De Internet');
        }
      default:
        {
          return const Center(child: CircularProgressIndicator());
        }
    }
  }

  Widget vista() {
    return Text('hola');
  }
}
