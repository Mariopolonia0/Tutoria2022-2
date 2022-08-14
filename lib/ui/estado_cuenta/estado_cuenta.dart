import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:projecto_ucne/data/remote/conexion_retrofit.dart';
import 'package:projecto_ucne/models/Dto/estado_dto.dart';
import '../../models/Dto/login_dto.dart';
import 'package:intl/intl.dart';

class EstadoCuenta extends StatefulWidget {
  const EstadoCuenta({super.key});

  @override
  State<EstadoCuenta> createState() => _EstadoCuentaState();
}

class _EstadoCuentaState extends State<EstadoCuenta> {
  final fonmKey = GlobalKey<FormState>();

  int loading = 0;

  String balance = '0.00';

  LoginDto arguments =
      LoginDto(estudianteId: 0, nombreEstudiante: '', matricula: '');

  List<EstadoDto> _estados = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context)!.settings.arguments as LoginDto;
    octenerMaterias();
    return Scaffold(
        backgroundColor: const Color(0xFF91D8F7),
        resizeToAvoidBottomInset: false,
        drawer: drawerMenuoption2(),
        appBar: AppBar(
            surfaceTintColor: Colors.white,
            backgroundColor: const Color(0xFF00247D),
            title: const Text('Estado De Cuenta')),
        body: obtenerVista(context));
  }

  Widget obtenerVista(BuildContext context) {
    switch (loading) {
      case 1:
        {
          return getEstado(context);
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

  Widget getEstado(BuildContext context) {
    return Column(
      children: [
        getSubTitulo(),
        Expanded(
          child: listaEstado(),
        ),
      ],
    );
  }

  Widget listaEstado() {
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          balance = formatearMonto(_estados[0].estado);
        }));
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        padding: const EdgeInsets.all(8),
        itemCount: _estados.length,
        itemBuilder: (BuildContext context, int index) => Padding(
              padding: const EdgeInsets.all(4),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                child: getItem(_estados[index]),
              ),
            ));
  }

  Row getItem(EstadoDto estadoDto) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 200,
              child: texto(estadoDto.descripcion),
            ),
            (estadoDto.transaccion >= 0.0)
                ? texto(formatearMonto(estadoDto.transaccion),
                    color: const Color(0xFF37B34A))
                : texto(formatearMonto(estadoDto.transaccion),
                    color: const Color(0xFFEC1C24))
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            texto(formatoFecha(estadoDto.fechaRealizado)),
            texto(formatearMonto(estadoDto.estado))
          ],
        ),
      ],
    );
  }

  Padding texto(String texto, {Color color = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
      child: Text(texto,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Algerian',
              color: color)),
    );
  }

  String formatearMonto(double texto) {
    return "\$ ${NumberFormat("#,###.0#", "es_US").format(texto)}";
  }

  String formatoFecha(String texto) {
    return texto.split('T')[0];
  }

  octenerMaterias() async {
    final client = RestClient(Dio(BaseOptions(
      contentType: Headers.jsonContentType,
      validateStatus: (_) => true,
    )));
    client.getEstados(arguments.estudianteId.toString()).then((value) {
      _estados = value;
      setState(() {
        loading = 1;
      });
    }).catchError((Object obj) {
      setState(() {
        loading = 2;
      });
    });
  }

  Container getSubTitulo() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(12),
      color: const Color(0xFF00247D),
      child: Text(
        'Balance General RD $balance',
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
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

                title: textwidgetblack('Estado De Cuenta'),
                leading: const Icon(Icons.attach_money_rounded,
                    color:  Color(0xFF000000)),

                onTap: () {
                  Navigator.of(context)
                      .pushNamed('/progresoAcademico', arguments: arguments);
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
                  Navigator.of(context)
                      .pushNamed('/progresoAcademico', arguments: arguments);
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

                leading: const Icon(Icons.school_rounded,
                    color:  Color(0xFF000000)),

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

                title: textwidgetblack('Materias de Hoy'),
                leading: const Icon(Icons.calendar_month_rounded,
                    color:  Color(0xFF000000)),

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
               title: textwidgetblack('Mis Datos'),
                leading: const Icon(Icons.file_present_rounded,
                    color:  Color(0xFF000000)),

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

  Padding textMenu(String text) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Text(text,
          style: const TextStyle(color: Color(0xFF959494), fontSize: 20)),
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
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 20)),
    );
  }

  Text textwidgetblack(String text) {
    return Text(text,
        style: const TextStyle(color: Colors.black, fontSize: 20));
  }
}
