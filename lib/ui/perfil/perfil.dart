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
    obtenerMaterias();
    return Scaffold(
      drawer: drawerMenuoption2(),
      appBar: AppBar(
          surfaceTintColor: Colors.white,
          backgroundColor: const Color(0xFF00247D),
          title: const Text('Mis Datos')),
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF91d8f7),
      body: obtenerVista(context),
    );
  }
  
  obtenerMaterias() async {
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

  Widget obtenerVista(BuildContext context) {
    switch (loading) {
      case 1:
        {
          return listarDatos();
        }
      case 2:
        {
          var klk = perfilDto.carrera;
          return Text('Error De Internet $klk');
        }
      default:
        {
          return const Center(child: CircularProgressIndicator());
        }
    }
  }

  Widget listarDatos() {
    return Column(children: [
      getSubTitulo(),
      obtenerDato(Icons.badge_rounded, 'Matricula', arguments.matricula),
      obtenerDato(Icons.email_rounded, 'Correo Insitucional', perfilDto.correo),
      obtenerDato(Icons.home_rounded, 'Nacionalidad', perfilDto.nacionalidad),
      obtenerDato(Icons.person, 'Tutor', perfilDto.tutor),
      obtenerDato(Icons.phone_android_rounded, 'Celular', perfilDto.celular),
    ]);
  }

  Container getSubTitulo() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment(0.8, 1),
        colors: <Color>[
           Color(0xFF00247D),
           Color(0xFFF62929),
        ],
      )),
      // Gradient from htt
      // color: const Color(0xFF00247D),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 22, 0, 0),
            child: Image.asset(
              'assets/icon/iconUcne.png',
              width: 100,
            ),
          ),
          Text(
            perfilDto.nombrecompleto,
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            perfilDto.carrera,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget obtenerDato(IconData icono, String textoTitulo, String textoInfo) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
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
              getTextoTitulo(textoTitulo),
            ],
          ),
          textoDato(textoInfo)
        ]),
      ),
    );
  }

  Widget getTextoTitulo(String texto) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
      child: Text(texto,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 0, 0),
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

  Drawer drawerMenuoption2() {
    return Drawer(
      child: Container(
          color: Colors.white,
          child: ListView(
            children: [
              SizedBox(
                height: 230,
                child: DrawerHeader(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment(0.8, 1),
                    colors: <Color>[
                       Color(0xFF00247D),
                       Color(0xFFF62929),
                    ],
                  )),
                  child: getHeader(),
                ),
              ),
              ListTile(
                title: textwidgetblack('Estado De Cuenta'),
                leading: const Icon(Icons.attach_money_rounded,
                    color:  Color(0xFF000000)),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed('/estadoCuenta', arguments: arguments);
                },
              ),
              ListTile(
                title: textwidgetblack('Progreso Académico'),
                leading: const Icon(Icons.school_rounded,
                    color:  Color(0xFF000000)),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed('/progresoAcademico', arguments: arguments);
                },
              ),
              ListTile(
                title: textwidgetblack('Materias de Hoy'),
                leading: const Icon(Icons.calendar_month_rounded,
                    color:  Color(0xFF000000)),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed('/materiaHoy', arguments: arguments);
                },
              ),
              ListTile(
                title: textwidgetblack('Mis Datos'),
                leading: const Icon(Icons.file_present_rounded,
                    color:  Color(0xFF000000)),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed('/perfil', arguments: arguments);
                },
              ),
              ListTile(
                title: textwidgetblack('Cerrar Sesión'),
                leading: const Icon(Icons.logout_rounded,
                    color:  Color(0xFF000000)),
                onTap: () {
                  Navigator.of(context).pushNamed('/', arguments: arguments);
                },
              ),
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
