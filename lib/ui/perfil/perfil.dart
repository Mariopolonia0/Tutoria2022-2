import 'package:flutter/material.dart';
import 'package:projecto_ucne/models/Dto/login_dto.dart';
//import '../../models/Dto/estudiante_dto.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  final fonmkey = GlobalKey<FormState>();

  final matriculaController = TextEditingController();
  final passwordController = TextEditingController();

  LoginDto arguments =
      LoginDto(estudianteId: 0, nombreEstudiante: '', matricula: '');
  // EstudianteDto(
  //     nombre: "",
  //     estudianteId: 0,
  //     carreraId: 0,
  //     personaId: 0,
  //     matricula: "",
  //     balancetotal: 0,
  //     balancependiente: 0);

  int loading = 0;

  @override
  Widget build(BuildContext context) {
    arguments = ModalRoute.of(context)!.settings.arguments as LoginDto;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: drawerMenuoption2(),
      appBar: AppBar(
          surfaceTintColor: Colors.white,
          backgroundColor: const Color(0xFF00247D),
          title: const Text('Perfil')),
      backgroundColor: const Color(0xFF91d8f7),
      body: obtenerVista(context),
    );
  }

  Widget obtenerVista(BuildContext context) {
    return listarDatos();
    /*switch (loading) {
      case 1:
        {
          return listarDatos();
        }
      case 2:
        {
          return const Text('Error De Internet');
        }
      default:
        {
          return const Center(child: CircularProgressIndicator());
        }
    }*/
  }

  Widget listarDatos() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(children: [
                  getItem(1),
                ]),
              )),
          Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(children: [
                  getItem(2),
                ]),
              )),
          Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(children: [
                  getItem(3),
                ]),
              )),
          Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(children: [
                  getItem(4),
                ]),
              )),
          Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(children: [
                  getItem(5),
                ]),
              )),
        ],
      ),
    );

    /* itemCount: 5,
      itemBuilder: (BuildContext context, int index) => Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                
              
            ),
          )),
    );*/

    /*ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: 5,
      itemBuilder: (BuildContext context, int index) => Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  getItem(1),
                  getItem(2),
                  getItem(3),
                  getItem(4),
                  getItem(5),
                ]
              ),
            ),
          )),
    );*/
  }

  Row getItem(/*PerfilDto materiaDto*/ int opcion) {
    Icon icono;
    String texto;
    //opcion++;
    switch (opcion) {
      case 2:
        icono = const Icon(Icons.mail_rounded, color: Color(0xFF00247D));
        texto = "Correo Insitucional";
        break;

      case 3:
        icono = const Icon(Icons.home, color: Color(0xFF00247D));
        texto = "Nacionalidad";
        break;

      case 4:
        icono = const Icon(Icons.person, color: Color(0xFF00247D));
        texto = "Tutor";
        break;

      case 5:
        icono =
            const Icon(Icons.phone_android_rounded, color: Color(0xFF00247D));
        texto = "Celular";
        break;

      default:
        icono =
            const Icon(Icons.assignment_ind_rounded, color: Color(0xFF00247D));
        texto = "Matícula";
    }
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        icono,
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textoTitulo(texto),
            Column(
              children: [
                textoDato("2019-0037"),
              ],
            ),
          ],
        )
      ],
    );
  }

  Padding textoTitulo(String texto, {Color color = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(texto,
          style: TextStyle(
              fontWeight: FontWeight.normal, color: color, fontSize: 16)),
    );
  }

  Padding textoDato(String texto, {Color color = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(texto,
          style: TextStyle(fontWeight: FontWeight.bold, color: color)),
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

  Text textwidgetblack(String text) {
    return Text(text,
        style: const TextStyle(color: Colors.black, fontSize: 20));
  }

  Padding textwidget(String text) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child:
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 20)),
    );
  }

  Column getHeader() {
    return Column(
      children: [
        Image.asset(
          'assets/icon/headerPerfil.png',
          width: 800,
          height: 134,
        ),
        textwidget(arguments.nombreEstudiante),
        textwidget(arguments.matricula)
      ],
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
