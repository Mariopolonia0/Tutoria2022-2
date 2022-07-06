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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(255, 202, 216, 223),
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
          desactivarprogress('Error de usuario o cantraseña',context);
        }
      }
    } on SocketException catch (_) {
      desactivarprogress('Error de internet', context);
    }
  }

  void desactivarprogress(String texto, BuildContext context) {
    setState(() {
      loading = false;
    });
    showDialog(
        context: context,
        builder: (BuildContext context) => alertDialog(texto, context));
  }

  loginCorrecto(LoginDto login) {
    Navigator.of(context).pushNamed('/materiaHoy', arguments: login);
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
            TextFormField(
              controller: matriculaController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'campo matricula esta vacío';
                }
                return null;
              },
              decoration: const InputDecoration(
                  labelText: "Matricula",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email_outlined)),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: passwortController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'campo contraseña esta vacío';
                }
                return null;
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.password_outlined),
                labelText: "Contraseña",
                border: OutlineInputBorder(),
              ),
            ),
            buttonLogin()
          ],
        ),
      ),
    );
  }

  Container buttonLogin() {
    return Container(
      child: TextButton(
        style: TextButton.styleFrom(
            padding: const EdgeInsets.all(8.0),
            textStyle: const TextStyle(
              fontSize: 26,
            )),
        onPressed: () {
          //LOGICA DEL LOGIN HAY QUE LLEVARLA PARA UNA FUNCION
          if (fonmKey.currentState!.validate()) {
            setState(() {
              loading = true;
            });
            validarlogin(matriculaController.text, passwortController.text);
          }
        },
        child: const Text("Conectar"),
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
