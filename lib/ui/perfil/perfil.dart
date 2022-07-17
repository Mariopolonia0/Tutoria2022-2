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

  var estudianteDto = EstudianteDto(
      nombre: "",
      estudianteId: 0,
      carreraId: 0,
      personaId: 0,
      matricula: "",
      balancetotal: 0,
      balancependiente: 0);

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFD3DFFF),
        body: loading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [formulario(context)],
              ));
  }

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
            buttonLogin()
          ],
        ),
      ),
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

  TextButton buttonLogin() {
    return TextButton.icon(
      style: TextButton.styleFrom(
          backgroundColor: const Color(0xFF00247D), //EC1C24
          padding: const EdgeInsets.all(8.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
      onPressed: () {
        if (fonmkey.currentState!.validate()) {
          setState(() {
            loading = true;
          });
          //validarlogin(matriculaController.text, passwortController.text);
        }
      },
      icon: const Icon(Icons.login_outlined, color: Colors.white),
      label: const Text("Ingresar",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
            color: Colors.white,
          )),
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
