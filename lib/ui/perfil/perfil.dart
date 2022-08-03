import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:projecto_ucne/data/remote/conexion_retrofit.dart';
import 'package:projecto_ucne/models/Dto/login_dto.dart';
import 'package:projecto_ucne/models/Dto/perfil_dto.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  LoginDto arguments =
      LoginDto(estudianteId: 0, nombreEstudiante: '', matricula: '');

  int loading = 0;

  PerfilDto perfilDto = PerfilDto("", "", "", "", "", "");

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context)!.settings.arguments as LoginDto;
    octenerMaterias();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF91d8f7),
      body: obtenerVista(context),
    );
  }

  Widget obtenerVista(BuildContext context) {
    switch (loading) {
      case 1:
        {
          return listarDatos();
        }
      case 2:
        {
          var klk = perfilDto.carrera;
          return  Text('Error De Internet $klk');
        }
      default:
        {
          return const Center(child: CircularProgressIndicator());
        }
    }
  }

  octenerMaterias() async {
    final client = RestClient(Dio(BaseOptions(
      contentType: Headers.jsonContentType,
      validateStatus: (_) => true,
    )));
    client.getPerfil(arguments.estudianteId.toString()).then((value) {
      perfilDto = value;
      setState(() {
        loading = 1;
      });
    }).catchError((Object obj) {
      setState(() {
        perfilDto.carrera = obj.toString();
        loading = 2;
      });
    });
  }

  Widget listarDatos() {
    return Column(children: [
      getSubTitulo(),
      octenerVista(Icons.badge_outlined, 'Matricula', arguments.matricula),
      octenerVista(Icons.email_outlined, 'Correo Insitucional', perfilDto.correo),
      octenerVista(Icons.home_outlined, 'Nacionalidad', perfilDto.nacionalidad),
      octenerVista(Icons.person, 'Tutor', perfilDto.tutor),
      octenerVista(Icons.phone_android_rounded, 'Celular', perfilDto.celular),
    ]);
  }

  Container getSubTitulo() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      color: const Color(0xFF00247D),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 26, 0, 0),
            child: Image.asset(
              'assets/icon/iconUcne.png',
              width: 100,
            ),
          ),
          Text(
            perfilDto.nombrecompleto,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
           Text(
            perfilDto.carrera,
            style:const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget octenerVista(IconData icono, String _textoTitulo, String _textoInfo) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Icon(
                icono,
                color: const Color(0xFF00247D),
                size: 30,
              ),
              textoTitulo(_textoTitulo),
            ],
          ),
          textoDato(_textoInfo)
        ]),
      ),
    );
  }

  Widget textoTitulo(String texto) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
      child: Text(texto,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF00247D),
              fontSize: 16)),
    );
  }

  Padding textoDato(String texto) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(texto,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          )),
    );
  }
}
