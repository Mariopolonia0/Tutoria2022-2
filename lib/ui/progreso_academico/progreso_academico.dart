import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:projecto_ucne/data/remote/conexion_retrofit.dart';
import 'package:projecto_ucne/models/Dto/progreso_dto.dart';
import '../../models/Dto/login_dto.dart';

class ProgresoAcademico extends StatefulWidget {
  const ProgresoAcademico({super.key});

  @override
  State<ProgresoAcademico> createState() => _ProgresoAcademicoState();
}

class _ProgresoAcademicoState extends State<ProgresoAcademico> {
  final fonmKey = GlobalKey<FormState>();

  int loading = 0;

  LoginDto arguments =
      LoginDto(estudianteId: 0, nombreEstudiante: '', matricula: '');

  List<ProgresoDto> _progresos = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context)!.settings.arguments as LoginDto;
    obtenerMaterias();
    return Scaffold(
      backgroundColor: const Color(0xFF91D8F7),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          surfaceTintColor: Colors.white,
          backgroundColor: const Color(0xFF00247D),
          title: const Text('Progreso Academico')),
      body: obtenerVista(context),
    );
  }

  obtenerMaterias() async {
    final client = RestClient(Dio(BaseOptions(
      contentType: Headers.jsonContentType,
      validateStatus: (_) => true,
    )));
    client.getProgreso(arguments.estudianteId.toString()).then((value) {
      _progresos = value;
      setState(() {
        loading = 1;
      });
    }).catchError((Object obj) {
      setState(() {
        loading = 2;
      });
    });
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getVista(_progresos[0]),
        getVista(_progresos[1]),
        getFiguraPastel(
            (_progresos[0].materiaAprobada + _progresos[1].materiaAprobada)
                .toDouble(),
            (_progresos[0].materiaPendiente + _progresos[1].materiaPendiente)
                .toDouble())
      ],
    );
  }

  Widget getVista(ProgresoDto progresoDto) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
        decoration: const BoxDecoration(
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

          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(progresoDto.tipoMateria,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
          getRow('Materia aprobada', progresoDto.materiaAprobada.toString(),
              const Color(0xFF37B34A)),
          getRow('Materia pendiente', progresoDto.materiaPendiente.toString(),
              const Color(0xFFEC1C24)),
          getRow('Materia requirido', progresoDto.materiaRequerida.toString(),
              const Color(0xFF00247D))
        ]),
      ),
    );
  }

  Widget getRow(String titulo, dato, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        textoDato(titulo, color: color),
        textoDato(dato, color: color)

      ],
    );
  }

  Padding textoDato(String texto, {Color color = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(texto,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: color, fontSize: 16)),
    );
  }

  Widget getFiguraPastel(double aprobada, double pendiente) {
    List<PieChartSectionData> sectionsChart = [
      PieChartSectionData(
        value: aprobada,
        showTitle: true,
        color: const Color(0xFF37B34A),
        radius: 100,
      ),
      PieChartSectionData(
        value: pendiente,
        showTitle: true,
        color: const Color(0xFFEC1C24),
        radius: 100,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: SizedBox(
          width: 230.0,
          height: 230.0,
          child: PieChart(
            PieChartData(
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: 0,
                sections: sectionsChart),
          ),
        ),
      ),
    );
  }
}
