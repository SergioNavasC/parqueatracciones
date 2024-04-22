import 'package:mysql1/mysql1.dart';

import 'database.dart';

class Usuario{

//Propiedades

int? idusuario;
String? nombre;
String? apellido;
String? dni;
String? correo;
String? password;

//Constructores
Usuario();

Usuario.fromMap(ResultRow map){
  idusuario = map["idusuario"];
  nombre = map["nombre"];
  apellido = map["apellido"];
  dni = map["dni"];
  correo = map["correo"];
  password = map["password"];
}

//Métodos
    insertarUsuario() async {
    var conn = await Database().conexion();
    try {
      await conn.query('INSERT INTO usuarios (nombre, password, dni, correo, apellido) VALUES (?,?,?,?,?)', [nombre, password, dni, correo, apellido]);
      print('Usuario insertado correctamente');
    } catch (e) {
      print(e);
    } finally {
      await conn.close();
    }
  }
}