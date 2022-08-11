import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../models/Dto/login_dto.dart';

class ProgresoAcademico extends StatefulWidget {
  const ProgresoAcademico({super.key});

  @override
  State<ProgresoAcademico> createState() => _ProgresoAcademicoState();
}

class _ProgresoAcademicoState extends State<ProgresoAcademico> {
  final fonmKey = GlobalKey<FormState>();

  int loading = 1;

  LoginDto arguments =
      LoginDto(estudianteId: 0, nombreEstudiante: '', matricula: '');

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context)!.settings.arguments as LoginDto;

    return Scaffold(
      backgroundColor: const Color(0xFF91D8F7),
      resizeToAvoidBottomInset: false,
      drawer: drawerMenuoption2(),
      appBar: AppBar(
          surfaceTintColor: Colors.white,
          backgroundColor: const Color(0xFF00247D),
          title: const Text('Progreso Academico')),
      body: obtenerVista(),
    );
  }

  Widget obtenerVista() {
    List<PieChartSectionData> sectionsChart = [
      PieChartSectionData(
        value: 35,
        title: "35%",
        showTitle: true,
        color: Colors.orange,
        radius: 100,
      ),
      PieChartSectionData(
        value: 45,
        title: "45%",
        showTitle: true,
        color: Colors.blue,
        radius: 100,
      ),
    ];

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 300,
      child: PieChart(
        PieChartData(
            borderData: FlBorderData(
              show: false,
            ),
            sectionsSpace: 0,
            centerSpaceRadius: 0,
            sections: sectionsChart),
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
