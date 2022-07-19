import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:projecto_ucne/data/remote/conexion_retrofit.dart';
import '../../models/Dto/login_dto.dart';
import '../../models/Dto/materia_dto.dart';

class MateriaHoy extends StatefulWidget {
  const MateriaHoy({super.key});

  @override
  State<MateriaHoy> createState() => _MateriaHoyState();
}

class _MateriaHoyState extends State<MateriaHoy> {
  final fonmKey = GlobalKey<FormState>();

  int loading = 0;

  LoginDto arguments =
      LoginDto(estudianteId: 0, nombreEstudiante: '', matricula: '');

  List<MateriaDto> _materiasDtos = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context)!.settings.arguments as LoginDto;
    octenerMaterias();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: drawerMenuoption2(),
      appBar: AppBar(
          surfaceTintColor: Colors.white,
          backgroundColor: const Color(0xFF00247D),
          title: const Text('Materia De Hoy')),


    );
  }

  Widget obtenerVista() {
    switch (loading) {
      case 1:
        {
          if (_materiasDtos.isNotEmpty) {
            return listaMateria();
          } else {
            return Center(
                child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: getNotieneMateria(),
            ));
          }
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

  Widget getNotieneMateria() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/icon/iconUcne.png',
          width: 100,
        ),
        const Text("Estimado estudiante no tiene docencia hoy.",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00247D))),
        const SizedBox(
          height: 18,
        ),
        const Text("Valoramos tu tiempo",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white)) //37B34A
      ],
    );
  }

  Widget listaMateria() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: _materiasDtos.length,
      itemBuilder: (BuildContext context, int index) => Padding(
          padding: const EdgeInsets.all(4),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: getItemMateria(_materiasDtos[index]),
            ),
          )),
    );
  }

  Row getItemMateria(MateriaDto materiaDto) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            texto(materiaDto.horaInicio, color: const Color(0xFF37B34A)),
            texto(materiaDto.horaFinal, color: const Color(0xFFEC1C24)),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            texto(materiaDto.nombreMateria),
            Row(
              children: [
                const Icon(Icons.apartment_outlined, color: Color(0xFF00247D)),
                texto(materiaDto.aula),
              ],
            )
          ],
        )
      ],
    );
  }

  Padding texto(String texto, {Color color = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(texto,
          style: TextStyle(fontWeight: FontWeight.bold, color: color)),
    );
  }


  octenerMaterias() async {
    final client = RestClient(Dio(BaseOptions(
      contentType: Headers.jsonContentType,
      validateStatus: (_) => true,
    )));
    client.getMateriaHoy(arguments.estudianteId.toString()).then((value) {
      _materiasDtos = value;
      setState(() {
        loading = 1;
      });
    }).catchError((Object obj) {
      const Text('Error de Internet');
    });
  }

  Drawer drawerMenuoption2() {
    return Drawer(
      child: Container(
          color: Colors.white,
          child: ListView(
            children: [
              SizedBox(
                height: 230,
                child: DrawerHeader(
                  decoration: const BoxDecoration(color: Color(0xFF00247D)),
                  child: getHeader(),
                ),
              ),
              ListTile(
                title: textwidgetblack('Materia De Hoy'),
                leading: const Icon(Icons.calendar_month),
                onTap: () {},
              ),
              ListTile(
                title: textwidgetblack('Estado De Cuenta'),
                leading: const Icon(Icons.balance),
                onTap: () {},
              ),
              ListTile(
                title: textwidgetblack('Credito Pendiente'),
                leading: const Icon(Icons.request_quote),
                onTap: () {},
              ),
              ListTile(
                title: textwidgetblack('Credito Aprobado'),
                leading: const Icon(Icons.price_check),
                onTap: () {},
              )
            ],
          )),
    );
  }

  Column getHeader() {
    return Column(
      children: [
        Image.asset(
          'assets/icon/iconUcne.png',
          width: 100,
        ),
        textwidget(arguments.nombreEstudiante),
        textwidget(arguments.matricula)
      ],
    );
  }

  Padding textwidget(String text) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child:
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 20)),
    );
  }

  Text textwidgetblack(String text) {
    return Text(text,
        style: const TextStyle(color: Colors.black, fontSize: 20));
  }
}
