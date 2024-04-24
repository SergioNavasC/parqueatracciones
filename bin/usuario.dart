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
///Este método es para poder insertar usuarios dentro de la base de datos
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
///Este método va a ser para poder iniciar sesion dentro de la APP
  loginUser() async {
    var conn = await Database().conexion();
    try {
      var resultado = await conn.query('SELECT * FROM usuarios WHERE nombre = ?', [nombre]);
      Usuario usuario = Usuario.fromMap(resultado.first);
      if (dni == usuario.dni) {
        return usuario;
      } else
        return false;
    } catch (e) {
      print(e);
      return false;
    } finally {
      await conn.close();
    }
  }

}