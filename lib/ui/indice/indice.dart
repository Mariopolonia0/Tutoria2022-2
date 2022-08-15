import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Indice extends StatefulWidget {
  const Indice({super.key});

  @override
  State<Indice> createState() => _IndiceState();
}

class _IndiceState extends State<Indice> {
  final fonmKey = GlobalKey<FormState>();

  int loading = 0;

  // LoginDto arguments =
  //     LoginDto(estudianteId: 0, nombreEstudiante: '', matricula: '');

  List<String>? listaYeard;
  String dropdownValue = "";

  @override
  Widget build(BuildContext context) {
    //arguments = ModalRoute.of(context)!.settings.arguments as LoginDto;

    return Scaffold(
        backgroundColor: const Color(0xFF91D8F7),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            surfaceTintColor: Colors.white,
            backgroundColor: const Color(0xFF00247D),
            title: const Text('Mis Calificaciones')),
        body: Center(child: Text('data')));
  }
}
