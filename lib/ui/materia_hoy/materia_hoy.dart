import 'package:flutter/material.dart';
import 'package:projecto_ucne/models/Dto/login_dto.dart';

class MateriaHoy extends StatefulWidget {
  const MateriaHoy({super.key});

  @override
  State<MateriaHoy> createState() => _MateriaHoyState();
}

class _MateriaHoyState extends State<MateriaHoy> {
  final fonmKey = GlobalKey<FormState>();

  final matriculaController = TextEditingController();

  final passwortController = TextEditingController();

  LoginDto arguments =
      LoginDto(estudianteId: 0, nombreEstudiante: '', matricula: '');

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context)!.settings.arguments as LoginDto;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: drawerMenuoption2(),
      appBar: AppBar(title: const Text('Materia De Hoy')),
      backgroundColor: const Color.fromARGB(255, 202, 216, 223),
    );
  }

  Drawer drawerMenuoption2() {
    return Drawer(
      child: Container(
          color: Colors.white,
          child: ListView(
            children: [
              SizedBox(
                height: 230,
                child: DrawerHeader(
                  decoration: const BoxDecoration(color: Colors.blue),
                  child: getHerder(),
                ),
              ),
              ListTile(
                title: textwidgetblack('Materia De Hoy'),
                leading: const Icon(Icons.calendar_month),
                onTap: () {},
              ),
              ListTile(
                title: textwidgetblack('Estado De Cuenta'),
                leading: const Icon(Icons.balance),
                onTap: () {},
              ),
              ListTile(
                title: textwidgetblack('Credito Pendiente'),
                leading: const Icon(Icons.request_quote),
                onTap: () {},
              ),
              ListTile(
                title: textwidgetblack('Credito Aprobado'),
                leading: const Icon(Icons.price_check),
                onTap: () {},
              )
            ],
          )),
    );
  }

  Column getHerder() {
    return Column(
      children: [
        Image.asset(
          'assets/icon/iconUcne.png',
          width: 100,
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
