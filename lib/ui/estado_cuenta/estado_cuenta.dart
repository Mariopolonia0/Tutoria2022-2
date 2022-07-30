import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:projecto_ucne/models/Dto/estado_dto.dart';
import '../../models/Dto/login_dto.dart';
import 'package:intl/intl.dart';

class EstadoCuenta extends StatefulWidget {
  const EstadoCuenta({super.key});

  @override
  State<EstadoCuenta> createState() => _EstadoCuentaState();
}

class _EstadoCuentaState extends State<EstadoCuenta> {
  final fonmKey = GlobalKey<FormState>();

  int loading = 1;

  String balance = '0.00';

  LoginDto arguments =
      LoginDto(estudianteId: 1, nombreEstudiante: 'Mario', matricula: '');

  //List<EstadoDto> _Estados = List.empty(growable: true);
  List<EstadoDto> _estados = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    //arguments = ModalRoute.of(context)!.settings.arguments as LoginDto;

    return Scaffold(
      backgroundColor: const Color(0xFF91D8F7),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          surfaceTintColor: Colors.white,
          backgroundColor: const Color(0xFF00247D),
          title: const Text('Estado De Cuenta')),
      body: obtenerVista(),
    );
  }

  Widget obtenerVista() {
    switch (loading) {
      case 1:
        {
          return getEstado();
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

  Widget getEstado() {
    return Column(
      children: [
        getSubTitulo(),
        listaMateria(),
      ],
    );
  }

  Widget listaMateria() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: 2,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) => Padding(
          padding: const EdgeInsets.all(4),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: getItemMateria(_estados[index]),
          )),
    );
  }

  Row getItemMateria(EstadoDto estadoDto) {
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
          balance = formatearMonto(estadoDto.estado);
        }));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            texto(estadoDto.descripcion),
            (estadoDto.transaccion > 0.0)
                ? texto(formatearMonto(estadoDto.transaccion),
                    color: const Color(0xFF37B34A))
                : texto(formatearMonto(estadoDto.transaccion),
                    color: const Color(0xFFEC1C24))
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            texto(estadoDto.fechaRealizado),
            texto(formatearMonto(estadoDto.estado))
          ],
        ),
      ],
    );
  }

  Padding texto(String texto, {Color color = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
      child: Text(texto,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Algerian',
              color: color)),
    );
  }

  String formatearMonto(double texto) {
    return "\$ ${NumberFormat("#,###.0#", "es_US").format(texto)}";
  }

  // octenerMaterias() async {
  //   final client = RestClient(Dio(BaseOptions(
  //     contentType: Headers.jsonContentType,
  //     validateStatus: (_) => true,
  //   )));
  //   client.getMateriaHoy(arguments.estudianteId.toString()).then((value) {
  //     _materiasDtos = value;
  //     setState(() {
  //       loading = 1;
  //     });
  //   }).catchError((Object obj) {
  //     const Text('Error de Internet');
  //   });
  // }

  Container getSubTitulo() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(12),
      color: const Color(0xFF00247D),
      child: Text(
        'Balance Generar RD\$ $balance',
        key: const Key("textKey"),
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
