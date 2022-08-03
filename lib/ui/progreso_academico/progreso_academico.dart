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
      LoginDto(estudianteId: 1, nombreEstudiante: '', matricula: '');

  @override
  Widget build(BuildContext context) {
    //arguments = ModalRoute.of(context)!.settings.arguments as LoginDto;

    return Scaffold(
      backgroundColor: const Color(0xFF91D8F7),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          surfaceTintColor: Colors.white,
          backgroundColor: const Color(0xFF00247D),
          title: const Text('Progreso Academico')),
      body: vista(),
    );
  }

  Widget vista() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getVista('Materia Obligatorias'),
        getVista('Materia Optativas'),
        getFiguraPastel(50, 50)
      ],
    );
  }

  Widget getVista(String titulo) {
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
          Text(titulo,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
          getRow('Materia aprobada', '55', const Color(0xFF37B34A)),
          getRow('Materia pendiente', '55', const Color(0xFFEC1C24)),
          getRow('Materia requirido', '55', const Color(0xFF00247D))
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
          style: TextStyle(fontWeight: FontWeight.bold, color: color)),
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
        padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
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
    );
  }
  // switch (loading) {
  //   case 1:
  //     {

  //       return Text('klk ${arguments.nombreEstudiante}');
  //     }
  //   case 2:
  //     {
  //       return const Text('Error De Internet');
  //     }
  //   default:
  //     {
  //       return const Center(child: CircularProgressIndicator());
  //     }
  // }
  // }
}
