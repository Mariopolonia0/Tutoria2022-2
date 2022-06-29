import 'package:flutter/material.dart';
import 'package:projecto_ucne/models/estudiante.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final fonmKey = GlobalKey<FormState>();
  final matriculaController = TextEditingController();
  final passwortController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(255, 202, 216, 223),
        body: formulario(context));
  }

  Form formulario(BuildContext context) {
    return Form(
        key: fonmKey,
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Image.asset(
                      'assets/icon/iconUcne.png',
                      width: 170,
                    ),
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
                    ),
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
                      labelText: "Contraseña",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(8.0),
                          textStyle: const TextStyle(
                            fontSize: 26,
                          )),
                      onPressed: () {
                        //LOGICA DEL LOGIN HAY QUE LLEVARLA PARA UNA FUNCION
                        if (fonmKey.currentState!.validate()) {
                          var estudiante = validadlogin(
                              matriculaController.text,
                              passwortController.text);
                          if (estudiante != null) {
                            Navigator.pushNamed(context, '/materiaHoy',
                                arguments: estudiante);
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => alertDialog(
                                    'Matricula o Password incorrecto',
                                    context));
                          }
                        }
                      },
                      child: const Text("Conectar"),
                    ),
                  )
                ],
              ),
            )));
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
//ESTA FUNCION ES DE PRUBA HAY QUE ELIMINARLA LUEGO
  Estudiante? validadlogin(String usuario, String password) {
    if (usuario == "2016-0037") {
      if (password == "1234") {
        return Estudiante(
            "Mario Peña Polonia", 20160037, 05, 5966, "2016-0037", 0.0, 0.0);
      }
    } else if (usuario == "2018-0616") {
      if (password == "1234") {
        return Estudiante(
            "Jesus Abreu", 20180616, 05, 5966, "2018-0616", 0.0, 0.0);
      }
    }
    return null;
  }
}
