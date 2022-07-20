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
    switch (loading) {
      case 1:
        {
          
          return Text('klk ${arguments.nombreEstudiante}');
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

}
