import 'package:flutter/material.dart';
import 'package:projecto_ucne/ui/login/login_screen.dart';
import 'package:projecto_ucne/ui/materia_hoy/materia_hoy.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Ucne Consulta",
      initialRoute: '/',
      //aqui ban las rutas de las ventanas
      routes: {
        '/': (context) => LoginScreen(),
        '/materiaHoy': (context) => const MateriaHoy()
      }));
}
