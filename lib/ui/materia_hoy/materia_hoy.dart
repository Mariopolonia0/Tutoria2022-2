import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:projecto_ucne/models/Dto/login_dto.dart';
import 'package:http/http.dart' as http;

import '../../models/Dto/materia_dto.dart';

class MateriaHoy extends StatefulWidget {
  const MateriaHoy({super.key});

  @override
  State<MateriaHoy> createState() => _MateriaHoyState();
}

class _MateriaHoyState extends State<MateriaHoy> {
  final fonmKey = GlobalKey<FormState>();

  final matriculaController = TextEditingController();

  final passwortController = TextEditingController();
  int loading = 0;

  LoginDto arguments =
      LoginDto(estudianteId: 0, nombreEstudiante: '', matricula: '');

  final List<MateriaDto> _materiasDtos = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context)!.settings.arguments as LoginDto;
    octenerMaterias();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: drawerMenuoption2(),
      appBar: AppBar(
          surfaceTintColor: Colors.white,
          backgroundColor: const Color(0xFF00247D),
          title: const Text('Materia De Hoy')),
      backgroundColor: const Color(0xFFD3DFFF),
      body: octenerVista(),
    );
  }

  Widget octenerVista() {
    switch (loading) {
      case 1:
        {
          if (_materiasDtos.isNotEmpty) {
            return listaMateria();
          } else {
            return const Text('No Tiene Materia Hoy');
          }
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

  Widget listaMateria() {
    return ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: _materiasDtos.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          color: Colors.white,
          child: Center(
              child: Column(
            children: [
              Text(index.toString()),
              Text(_materiasDtos[index].nombreMateria),
            ],
          )),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  octenerMaterias() async {
    try {
      var valor = arguments.estudianteId;
      var response = await http.post(
        Uri.parse(
            'https://tutoria2022.azurewebsites.net/api/MateriaHoy?estudianteId=$valor'),
        headers: {"accept": "text/plain"},
      );
      if (response.statusCode == 200) {
        if (_materiasDtos.isEmpty) {
          for (var element in json.decode(response.body)) {
            _materiasDtos.add(MateriaDto.fromJson(element));
          }
          setState(() {
            loading = 1;
          });
        }
        return;
      } else {
        setState(() {
          loading = 2;
        });
      }
    } on SocketException catch (_) {
      setState(() {
        loading = 3;
      });
    }
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
                  decoration: const BoxDecoration(color:Color(0xFF00247D)),
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
