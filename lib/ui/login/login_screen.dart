import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:projecto_ucne/data/remote/conexion_retrofit.dart';

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

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF91D8F7),
        body: loading
            ? const Center(child: CircularProgressIndicator())
            : formulario(context));
  }

  validarlogin() {
    final client = RestClient(Dio(BaseOptions(
      contentType: Headers.jsonContentType,
      validateStatus: (_) => true,
    )));

    client
        .hacerLogin(matriculaController.text, passwortController.text)
        .then((login) {
      setState(() {
        loading = false;
      });
      if (login.estudianteId == 0) {
        desactivarprogress('Matricula y contraseña incorrecto');
      } else {
        Navigator.of(context).popAndPushNamed('/materiaHoy', arguments: login);
      }
    }).catchError((Object obj) {
      desactivarprogress('Error de internet');
    });
  }

  void desactivarprogress(String texto) {
    setState(() {
      loading = false;
    });
    showDialog(
        context: context,
        builder: (BuildContext context) => alertDialog(texto, context));
  }

  Form formulario(BuildContext context) {
    return Form(
      key: fonmKey,
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            texto(),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 0, 30, 0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    textFormField('Matricula', Icons.person_outline,
                        matriculaController, false),
                    const SizedBox(
                      height: 8,
                    ),
                    textFormField('Contraseña', Icons.key_rounded,
                        passwortController, true),
                    const SizedBox(
                      height: 8,
                    ),
                    buttonLogin(context),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget texto() {
    return Column(
      children: const [
        Text(
          "Universidad Catolica Nordestana",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          'UCNE',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 100,
              color: Color(0xFF00247D),
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  TextFormField textFormField(String texto, IconData icon,
      TextEditingController controller, bool ocultar) {
    return TextFormField(
      obscuringCharacter: "*",
      obscureText: ocultar,
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return 'campo $texto esta vacío';
        }
        return null;
      },
      // style: const TextStyle(color: Color(0xFF00247D)),
      decoration: InputDecoration(
        labelText: texto,
        labelStyle: const TextStyle(
          color: Color(0xFF00247D),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF00247D), width: 2.0),
          borderRadius: BorderRadius.circular(15.0),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF00247D), width: 2.0),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        prefixIcon: Icon(
          icon,
          size: 30,
          color: const Color(0xFF00247D),
        ),
      ),
    );
  }

  TextButton buttonLogin(BuildContext context) {
    return TextButton.icon(
      style: TextButton.styleFrom(
          backgroundColor: const Color(0xFF00247D), //EC1C24
          padding: const EdgeInsets.all(12.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
      onPressed: () {
        if (fonmKey.currentState!.validate()) {
          setState(() {
            loading = true;
          });
          validarlogin();
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
