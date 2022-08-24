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
  int loading2 = 0;
  int contador = 0;

  LoginDto arguments =
      LoginDto(estudianteId: 0, nombreEstudiante: '', matricula: '');

  List<MateriaDto> _listMateriasDtos = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context)!.settings.arguments as LoginDto;
    obtenerMaterias();
    return Scaffold(
      backgroundColor: const Color(0xFF91D8F7),
      resizeToAvoidBottomInset: false,
      drawer: drawerMenuoption2(),
      appBar: AppBar(
          surfaceTintColor: Colors.white,
          backgroundColor: const Color(0xFF00247D),
          title: const Text('Horario')),
      body: obtenerVista(),
    );
  }

  Widget obtenerVista() {
    List<MateriaDto> listaNueva = organizarMaterias(_materiasDtos);
    switch (loading) {
      case 1:
        {

          if (_listMateriasDtos.isNotEmpty) {
            return pintarMateriaPorDia();

          } else {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: getNotieneMateria(),
              ),
            );
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


  Widget pintarMateriaPorDia() {
    //el expande hacer que el column coja la pantalla disponible
    //SingleChildScrollView es para hacer scrool
    //en lo que este dentro de el
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
        child: Column(
          children: [
            pintarMaterias('Lunes', 'Monday'),
            pintarMaterias('Martes', 'Tuesday'),
            pintarMaterias('Miércoles', 'Wednesday'),
            pintarMaterias('Jueves', 'Thursday'),
            pintarMaterias('Viernes', 'Friday'),
            pintarMaterias('Sábado', 'Saturday'),
            pintarMaterias('Domingo', 'Sunday')
          ],

        ),
      ),
    );
  }


  Widget pintarMaterias(String diaSpanish, diaEnglish) {
    //esta funcion organiza una lista cnon los dia que sean iguales
    //y llena un column con esa lista y si la lista queda bacia
    //el widget retorna un widget vacio
    List<MateriaDto> list = List.empty(growable: true);


    for (var item in _listMateriasDtos) {
      if (item.dia == diaEnglish) list.add(item);
    }

    return (list.isEmpty)
        ? vacio()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textoDia(diaSpanish),
              Column(
                children: list.map((materiaDto) {
                  return fondoMateria(materiaDto);
                }).toList(),
              ),
            ],
          );
  }

  Widget vacio() {
    return const SizedBox.shrink();
  }


  Widget fondoMateria(MateriaDto materiaDto) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 4, 4, 4),
          child: Container(
            child: getItemMateria(materiaDto),
          ),
        ),
      ),
    );
  }

  Widget getItemMateria(MateriaDto materiaDto) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            texto(materiaDto.horaInicio, color: const Color(0xFF37B34A)),
            texto(materiaDto.horaFinal, color: const Color(0xFFEC1C24)),
          ],
        ),
        Expanded(
            child: Column(
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
        ))
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

  Padding textoDia(String texto) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12 + 8, 8, 0, 0),
      child: Text(texto,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF00247D),
              fontSize: 24)),
    );
  }

  obtenerMaterias() async {
    final client = RestClient(Dio(BaseOptions(
      contentType: Headers.jsonContentType,
      validateStatus: (_) => true,
    )));
    client.getMateriaHoy(arguments.estudianteId.toString()).then((value) {
      _listMateriasDtos = value;
      setState(() {
        loading = 1;
      });
    }).catchError((Object obj) {
      const Text('Error de Internet');
    });
  }


  Widget getNotieneMateria() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/icon/iconUcne.png',
          width: 100,
        ),
        const Text("Estimado estudiante, no tiene docencia hoy.",
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
                fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white))
      ],
    );
  }

  Drawer drawerMenuoption2() {
    return Drawer(
      child: Container(
          color: Colors.white,
          child: ListView(
            children: [
              SizedBox(
                height: 190,
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

              //Academico
              ListTile(
                horizontalTitleGap: 1,
                dense: true,
                title: textMenu('Académico'),
                leading: const Icon(
                  Icons.school_rounded,
                  color: Color(0xFF959494),
                ),
              ),

              ListTile(
                horizontalTitleGap: 1,
                dense: true,
                contentPadding: const EdgeInsets.only(left: 40),
                title: textwidgetblack('Calificaciones'),
                leading: const Icon(
                  Icons.event_available_rounded,
                  color: Color(0xFF000000),
                ),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed('/calificaciones', arguments: arguments);
                },
              ),

              ListTile(
                horizontalTitleGap: 1,
                dense: true,
                contentPadding: const EdgeInsets.only(left: 40),
                title: textwidgetblack('Mi Horario'),
                leading: const Icon(
                  Icons.calendar_month_rounded,
                  color: Color(0xFF000000),
                ),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed('/materiaHoy', arguments: arguments);
                },
              ),

              ListTile(
                horizontalTitleGap: 1,
                dense: true,
                contentPadding: const EdgeInsets.only(left: 40),
                title: textwidgetblack('Notificaciones'),
                leading: const Icon(
                  Icons.notifications,
                  color: Color(0xFF000000),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('/', arguments: arguments);
                },
              ),

              ListTile(
                horizontalTitleGap: 1,
                dense: true,
                contentPadding: const EdgeInsets.only(left: 40),
                title: textwidgetblack('Progreso Académico'),
                leading: const Icon(
                  Icons.school_rounded,
                  color: Color(0xFF000000),
                ),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed('/progresoAcademico', arguments: arguments);
                },
              ),

              //Balances y pagos
              ListTile(
                horizontalTitleGap: 1,
                dense: true,
                title: textMenu('Balances y Pagos'),
                leading: const Icon(
                  Icons.currency_exchange_rounded,
                  color: Color(0xFF959494),
                ),
              ),

              ListTile(
                horizontalTitleGap: 1,
                dense: true,
                contentPadding: const EdgeInsets.only(left: 40),
                title: textwidgetblack('Estado De Cuenta'),
                leading: const Icon(
                  Icons.attach_money_rounded,
                  color: Color(0xFF000000),
                ),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed('/estadoCuenta', arguments: arguments);
                },
              ),

              //Configuracion
              ListTile(
                horizontalTitleGap: 1,
                dense: true,
                title: textMenu('Configuración'),
                leading: const Icon(
                  Icons.settings_rounded,
                  color: Color(0xFF959494),
                ),
              ),
              ListTile(
                horizontalTitleGap: 1,
                dense: true,
                contentPadding: const EdgeInsets.only(left: 40),
                title: textwidgetblack('Mi perfil'),
                leading: const Icon(Icons.text_snippet_rounded,
                    color: Color(0xFF000000)),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed('/perfil', arguments: arguments);
                },
              ),
              ListTile(
                horizontalTitleGap: 1,
                dense: true,
                contentPadding: const EdgeInsets.only(left: 40),
                title: textwidgetblack('Cerrar Sesión'),
                leading:
                    const Icon(Icons.logout_rounded, color: Color(0xFF000000)),
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
          height: 90,
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
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 18)),
    );
  }

  Padding textMenu(String text) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Text(text,
          style: const TextStyle(color: Color(0xFF959494), fontSize: 20)),
    );
  }

  Text textwidgetblack(String text) {
    return Text(text,
        style: const TextStyle(color: Colors.black, fontSize: 18));
  }
}