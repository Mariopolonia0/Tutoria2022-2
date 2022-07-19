import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../models/Dto/estudiante_dto.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  final fonmkey = GlobalKey<FormState>();

  final matriculaController = TextEditingController();
  final passwordController = TextEditingController();

  var arguments = EstudianteDto(
      nombre: "",
      estudianteId: 0,
      carreraId: 0,
      personaId: 0,
      matricula: "",
      balancetotal: 0,
      balancependiente: 0);

  int loading = 0;

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context)!.settings.arguments as EstudianteDto;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: drawerMenuoption2(),
      appBar: AppBar(
          surfaceTintColor: Colors.white,
          backgroundColor: const Color(0xFF00247D),
          title: const Text('Perfil')),
      backgroundColor: const Color(0xFFD3DFFF),
      body: obtenerVista(),
    );
  }

  Widget obtenerVista() {
    switch (loading) {
      case 1:
        {
          return const Text('Error De Internet');
        }
      default:
        {
          return const Center(child: CircularProgressIndicator());
        }
    }
  }
  /*
  Form formulario(BuildContext context) {
    return Form(
      key: fonmkey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              'assets/icon/iconUcne.png',
              width: 110,
            ),
            const SizedBox(
              height: 8,
            ),
            textFormField('Matricula', Icons.account_circle_outlined,
                matriculaController),
            const SizedBox(
              height: 8,
            ),
            textFormField(
                'Contraseña', Icons.password_outlined, passwordController),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
*/

  Drawer drawerMenuoption2() {
    return Drawer(
      child: Container(
          color: Colors.white,
          child: ListView(
            children: [
              SizedBox(
                height: 230,
                child: DrawerHeader(
                  decoration: const BoxDecoration(color: Color(0xFF00247D)),
                  child: getHeader(),
                ),
              ),
              ListTile(
                title: textwidgetblack('Matrícula'),
                leading: const Icon(Icons.person),
                onTap: () {},
              ),
              ListTile(
                title: textwidgetblack('Correo Institucional'),
                leading: const Icon(Icons.mail),
                onTap: () {},
              ),
              ListTile(
                title: textwidgetblack('Nacionalidad'),
                leading: const Icon(Icons.home),
                onTap: () {},
              ),
              ListTile(
                title: textwidgetblack('Teléfono'),
                leading: const Icon(Icons.phone),
                onTap: () {},
              ),
              ListTile(
                title: textwidgetblack('Celular'),
                leading: const Icon(Icons.phone_android),
                onTap: () {},
              )
            ],
          )),
    );
  }

  Text textwidgetblack(String text) {
    return Text(text,
        style: const TextStyle(color: Colors.black, fontSize: 20));
  }

  Padding textwidget(String text) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child:
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 20)),
    );
  }

  Column getHeader() {
    return Column(
      children: [
        Image.asset(
          'assets/icon/headerPerfil.png',
          width: 100,
        ),
        textwidget(arguments.nombre),
        textwidget(arguments.matricula)
      ],
    );
  }

  TextFormField textFormField(
      String texto, IconData icon, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'campo $texto esta vacío';
        }
        return null;
      },
      style: const TextStyle(color: Color(0xFF00247D)),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: texto,
        hintStyle: const TextStyle(color: Color(0xFF5A6581)),
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(),
        prefixIcon: Icon(
          icon,
          color: const Color(0xFF00247D),
        ),
      ),
    );
  }

  //ESTA HAY QUE PONERLA EN EL PAQUETE DE UTIL
  AlertDialog alertDialog(String informacion, BuildContext context) {
    return AlertDialog(
      title: const Text("Informacion"),
      content: Text(informacion),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Ok"))
      ],
    );
  }
}
