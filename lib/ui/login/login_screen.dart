import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:projecto_ucne/models/Dto/login_dto.dart';
import 'package:http/http.dart' as http;

//ORDENAR ESTE CODIGO MEJOR
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final fonmKey = GlobalKey<FormState>();

  final matriculaController = TextEditingController();

  final passwortController = TextEditingController();

  var logindto = LoginDto(estudianteId: 0, nombreEstudiante: "", matricula: "");
  bool loading = false;

// surfaceTintColor: Colors.white,
//           backgroundColor: const Color(0xFF00247D),
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

  validarlogin(String usuario, password) async {
    try {
      var response = await http.post(
        Uri.parse(
            'https://tutoria2022.azurewebsites.net/api/Login?Usuario=$usuario&Password=$password'),
        headers: {"accept": "text/plain"},
      );
      if (response.statusCode == 200) {
        var login = LoginDto.fromJson(json.decode(response.body));
        if (login.estudianteId > 0) {
          loginCorrecto(login);
        } else {
          desactivarprogress('Error de usuario o cantraseña');
        }
      }
    } on SocketException catch (_) {
      desactivarprogress('Error de internet');
    }
  }

  void desactivarprogress(String texto) {
    setState(() {
      loading = false;
    });
    showDialog(
        context: context,
        builder: (BuildContext context) => alertDialog(texto, context));
  }

  loginCorrecto(LoginDto login) {
    setState(() {
      loading = false;
    });
    Navigator.of(context).pushNamed('/perfil', arguments: login);
  }

  Form formulario(BuildContext context) {
    return Form(
      key: fonmKey,
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
                'Contraseña', Icons.password_outlined, passwortController),
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
        if (fonmKey.currentState!.validate()) {
          setState(() {
            loading = true;
          });
          validarlogin(matriculaController.text, passwortController.text);
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
