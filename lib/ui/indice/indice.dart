import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:projecto_ucne/data/remote/conexion_retrofit.dart';
import 'package:projecto_ucne/models/Dto/indice_dto.dart';
import '../../models/Dto/login_dto.dart';

class Indice extends StatefulWidget {
  const Indice({super.key});

  @override
  State<Indice> createState() => _IndiceState();
}

class _IndiceState extends State<Indice> {
  final fonmKey = GlobalKey<FormState>();

  int loading = 0;

  LoginDto arguments =
      LoginDto(estudianteId: 0, nombreEstudiante: '', matricula: '');

  IndiceDto? indiceDto;

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context)!.settings.arguments as LoginDto;
    obtenerIndice();
    return Scaffold(
        backgroundColor: const Color(0xFF91D8F7),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            surfaceTintColor: Colors.white,
            backgroundColor: const Color(0xFF00247D),
            title: const Text('Mi Índice')),
        body: obtenerVista(context));
  }

  Widget obtenerVista(BuildContext context) {
    switch (loading) {
      case 1:
        {
          return vistaIndice();
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

  Widget vistaIndice() {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
          height: 190,
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Column(
            children: [getPeriodo(), getIndices()],
          )),
    ));
  }

  Widget getPeriodo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Color(0xFF91D8F7),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'PERÍODO',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'AÑO',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    indiceDto!.meses,
                    style: const TextStyle(
                        color: Color(0xFF00247D),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(indiceDto!.yeard,
                      style: const TextStyle(
                          color: Color(0xFF00247D),
                          fontSize: 20,
                          fontWeight: FontWeight.bold))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getIndices() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Índice del período',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(indiceDto!.indicePeriodo,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold))
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Índice del acumulado',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(indiceDto!.indiceAcumulado,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold))
              ],
            ),
          )
        ],
      ),
    );
  }

  obtenerIndice() async {
    final client = RestClient(Dio(BaseOptions(
      contentType: Headers.jsonContentType,
      validateStatus: (_) => true,
    )));
    client
        .getIndice(
            arguments.estudianteId.toString(), arguments.nombreEstudiante)
        .then((value) {
      indiceDto = value;
      setState(() {
        loading = 1;
      });
    }).catchError((Object obj) {
      setState(() {
        loading = 2;
      });
    });
  }
}
