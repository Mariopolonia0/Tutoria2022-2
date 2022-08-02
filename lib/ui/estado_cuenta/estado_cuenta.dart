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
  // ignore: non_constant_identifier_names
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
      drawer: drawerMenuoption2(),
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

  Drawer drawerMenuoption2() {
    return Drawer(
      child: Container(
          color: Colors.white,
          child: ListView(
            children: [
              SizedBox(
                height: 230,
                child: DrawerHeader(
                  decoration: const BoxDecoration(color: Color(0xFF00247D)),
                  child: getHeader(),
                ),
              ),
              ListTile(
                title: textwidgetblack('Estado De Cuenta'),
                leading: const Icon(Icons.attach_money_outlined),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed('/estadoCuenta', arguments: arguments);
                },
              ),
              ListTile(
                title: textwidgetblack('Progreso Académico'),
                leading: const Icon(Icons.school_outlined),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed('/progresoAcademico', arguments: arguments);
                },
              ),
              ListTile(
                title: textwidgetblack('Mis Datos'),
                leading: const Icon(Icons.file_present_outlined),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed('/perfil', arguments: arguments);
                },
              ),
              ListTile(
                title: textwidgetblack('Materias de Hoy'),
                leading: const Icon(Icons.calendar_today_outlined),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed('/materiaHoy', arguments: arguments);
                },
              ),
              ListTile(
                title: textwidgetblack('Cerrar Sesión'),
                leading: const Icon(Icons.logout_rounded),
                onTap: () {
                  Navigator.of(context).pushNamed('/', arguments: arguments);
                },
              ),
            ],
          )),
    );
  }

  Column getHeader() {
    return Column(
      children: [
        Image.asset(
          'assets/icon/iconUcne.png',
          width: 100,
        ),
        textwidget(arguments.nombreEstudiante),
        textwidget(arguments.matricula)
      ],
    );
  }

  Padding textwidget(String text) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child:
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 20)),
    );
  }

  Text textwidgetblack(String text) {
    return Text(text,
        style: const TextStyle(color: Colors.black, fontSize: 20));
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
