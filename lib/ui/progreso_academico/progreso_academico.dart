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
  }
}
