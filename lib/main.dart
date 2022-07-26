import 'package:flutter/material.dart';
import 'package:projecto_ucne/ui/estado_cuenta/estado_cuenta.dart';
import 'package:projecto_ucne/ui/login/login_screen.dart';
import 'package:projecto_ucne/ui/materia_hoy/materia_hoy.dart';
import 'package:projecto_ucne/ui/perfil/perfil.dart';
import 'package:projecto_ucne/ui/progreso_academico/progreso_academico.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Ucne Consulta",
      initialRoute: '/',
      //aqui van las rutas de las ventanas
      routes: {
        '/': (context) => const LoginScreen(),
        '/materiaHoy': (context) => const MateriaHoy(),
        '/perfil': (context) => const Perfil(),
        '/estadoCuenta': (context) => const EstadoCuenta(),
        '/progresoAcademico': (context) => const ProgresoAcademico()
      }));
}
