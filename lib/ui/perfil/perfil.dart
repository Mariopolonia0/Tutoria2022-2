import 'package:flutter/material.dart';
import 'package:projecto_ucne/models/Dto/login_dto.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  final fonmkey = GlobalKey<FormState>();

  final matriculaController = TextEditingController();
  final passwordController = TextEditingController();

  LoginDto arguments =
      LoginDto(estudianteId: 0, nombreEstudiante: '', matricula: '');

  int loading = 0;

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context)!.settings.arguments as LoginDto;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF91d8f7),
      body: obtenerVista(context),
    );
  }

  Widget obtenerVista(BuildContext context) {
    return listarDatos();
    /*switch (loading) {
      case 1:
        {
          return listarDatos();
        }
      case 2:
        {
          return const Text('Error De Internet');
        }
      default:
        {
          return const Center(child: CircularProgressIndicator());
        }
    }*/
  }

  Widget listarDatos() {
    return Column(children: [
      getSubTitulo(),
      octenerVista(Icons.badge_outlined, 'Matricula', 'Hola'),
      octenerVista(Icons.email_outlined, 'Correo Insitucional', 'Hola'),
      octenerVista(Icons.home_outlined, 'Nacionalidad', 'Hola'),
      octenerVista(Icons.person, 'Tutor', 'Hola'),
      octenerVista(Icons.phone_android_rounded, 'Celular', 'Hola'),
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
            arguments.nombreEstudiante,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const Text(
            'Ingeniero en Sistemas y Computación',
            style: TextStyle(
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
