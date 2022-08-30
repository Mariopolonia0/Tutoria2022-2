import 'package:flutter/material.dart';

class Nortificacion extends StatefulWidget {
  const Nortificacion({super.key});

  @override
  State<Nortificacion> createState() => _NortificacionState();
}

class _NortificacionState extends State<Nortificacion> {
  final fonmKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF91D8F7),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          surfaceTintColor: Colors.white,
          backgroundColor: const Color(0xFF00247D),
          title: const Text('Notificación')),
      body: obtenerVista(),
    );
  }

  Widget obtenerVista() {
    return Center(
      child: Container(
        height: 150,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: getTexto(),
      ),
    );
  }

  Widget getTexto() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: const [
          Text(
            "No tiene notificacion.",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 18,
          ),
          Text(
            "Universidad Católica Nordestana",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF00247D),
            ),
          ),
          Text(
            "Valoramos tu tiempo",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF00247D),
            ),
          ),
        ],
      ),
    );
  }
}
