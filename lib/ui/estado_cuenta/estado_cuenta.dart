import 'package:flutter/material.dart';
import 'package:projecto_ucne/models/Dto/estado_dto.dart';
import '../../models/Dto/login_dto.dart';

class EstadoCuenta extends StatefulWidget {
  const EstadoCuenta({super.key});

  @override
  State<EstadoCuenta> createState() => _EstadoCuentaState();
}

class _EstadoCuentaState extends State<EstadoCuenta> {
  final fonmKey = GlobalKey<FormState>();

  int loading = 1;

  LoginDto arguments =
      LoginDto(estudianteId: 1, nombreEstudiante: 'Mario', matricula: '');

  //List<EstadoDto> _Estados = List.empty(growable: true);
  List<EstadoDto> _Estados = [
    EstadoDto(
        descripcion: 'hola',
        fechaRealizado: '22/10/2018',
        transaccion: 9000.0,
        estado: 25000),
    EstadoDto(
        descripcion: 'Adios',
        fechaRealizado: '22/10/2019',
        transaccion: 9000.0,
        estado: 25000),
  ];

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
        //getSubTitulo(),
        listaMateria()
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
            child: getItemMateria(_Estados[index]),
          )),
    );
  }

  Row getItemMateria(EstadoDto estadoDto) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            texto(estadoDto.descripcion),
            //texto(formatoDinero(estadoDto.transaccion), color: const Color(0xFFEC1C24)),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            texto(estadoDto.fechaRealizado),
            //texto(formatoDinero(estadoDto.estado)),
          ],
        ),
      ],
    );
  }

  

  Padding texto(String texto, {Color color = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
      child: Text(texto,
          style: TextStyle(fontWeight: FontWeight.bold, color: color)),
    );
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
      child: const Text(
        'Balance Generar RD\$ 13,000.0',
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
