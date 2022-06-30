import 'package:flutter/material.dart';
import 'package:projecto_ucne/models/estudiante.dart';

class MateriaHoy extends StatelessWidget {
  MateriaHoy({super.key});

  final fonmKey = GlobalKey<FormState>();
  final matriculaController = TextEditingController();
  final passwortController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Estudiante arguments = ModalRoute.of(context)!.settings.arguments as Estudiante;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                width: 100,
                margin: const EdgeInsets.all(50),
                child: Image.asset(
                  'assets/icon/iconUcne.png',
                  width: 100,
                ),
              ),
              Container(
                  margin: const EdgeInsets.all(5),
                  child: Text(arguments.matricula)),
              Container(
                  margin: const EdgeInsets.all(5),
                  child: Text(arguments.nombre))
            ],
          ),
        ),
      ),
      appBar: AppBar(title: const Text('Materia De Hoy')),
      backgroundColor: const Color.fromARGB(255, 202, 216, 223),
    );
  }
}
