import 'package:flutter/material.dart';
import '../../models/Dto/login_dto.dart';

class EstadoCuenta extends StatefulWidget {
  const EstadoCuenta({super.key});

  @override
  State<EstadoCuenta> createState() => _EstadoCuentaState();
}

class _EstadoCuentaState extends State<EstadoCuenta> {
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
          title: const Text('Estado De Cuenta')),
      body: obtenerVista(),
    );
  }

  Widget obtenerVista() {
    switch (loading) {
      case 1:
        {
          return getEstado();
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

  Widget getEstado() {
    return Column(
      children: [getSubTitulo()],
    );
  }

  Row getSubTitulo() {
    return Row(
      children: const [
        Icon(
          Icons.paid_outlined,
          color: Colors.white,
          size: 24.0,
        ),
        Text(
          'Balance Generar : RD\$  ',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        )
      ],
    );
  }
}
