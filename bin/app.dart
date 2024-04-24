import "dart:io";

import "usuario.dart";
class App{

  ///Esto va a ser para poder iniciar sesion o registrarse en la pagina.

  menuInicial(){
    int? respuesta;
    do {
        stdout.writeln("""
          1-Inicio Sesión
          2-Registro 
        """);
      respuesta = parsearRespuesta();
    } while (menuInicialRespuesta(respuesta));
    switch(respuesta){
      case 1:
      //print("Esto va a ser un inicio de usuario a la pagina"); 
        login();
        break;
      case 2:
      //print("Esto va a ser para crear usuarios");
        crearUsuario();
        break;
    }
  }
   menuLogin(Usuario usuario){
      int? respuesta;
      String? nombre = usuario.nombre;
      do {
          stdout.writeln(""" Bienvenido de nuevo $nombre, que desea hacer hoy? 
            1-Tipos de Tarifas
            2-Añadir metodos de pago
            3- Comprobar tipo de tarifa  
          """);
      respuesta = parsearRespuesta();
      } while (menuLoginRespuesta(respuesta));
      switch(respuesta){
        case 1:
          print("Aqui van a salir todos los tipos de tarifas");
          //tiposTarifas();
          break;
        case 2:
          print("Aqui va a ser para añadir los metodos de pago adicionales");
          //mostrarMetodosPago();
          break;
        case 3:
          print("Esto va a ser para comprobar el tipo de tarifa que tiene el usuario");
          //comprobarTarifa();
          break;
      }
    }
// Metodos
  crearUsuario() async{
    Usuario usuario = new Usuario();
    stdout.writeln("Escribe tu Nombre aqui ");
    usuario.nombre = stdin.readLineSync();
    stdout.writeln("Escribe tu Apellido aqui ");
    usuario.apellido = stdin.readLineSync();
    stdout.writeln("Escribe tu DNI aqui ");
    usuario.dni = stdin.readLineSync();
    stdout.writeln("Escribe tu correo aqui ");
    usuario.correo = stdin.readLineSync();
    stdout.writeln("Escribe tu contraseña aqui ");
    usuario.password = stdin.readLineSync();

    await usuario.insertarUsuario();
    menuInicial();
  }
  login() async {
    Usuario usuario = new Usuario();
    stdout.writeln("Escribe tu nombre");
    usuario.nombre = stdin.readLineSync();
    stdout.writeln("escribe tu contraseña aqui");
    usuario.password = stdin.readLineSync();
    stdout.writeln("Escribe tu dni aqui");
    
    usuario.dni = stdin.readLineSync();
    var resultado = await usuario.loginUser();
    if(resultado == false){
      stdout.writeln('Tu nombre de usuario o contraseña son incorrectos');
      menuInicial();
    } else {
      menuLogin(resultado);
    }
  }
}
bool menuInicialRespuesta(var respuesta) => respuesta == null || respuesta !=1 && respuesta !=2;
int? parsearRespuesta() => int.tryParse(stdin.readLineSync() ?? 'e');
bool menuLoginRespuesta(var respuesta) => respuesta == null || respuesta !=1 && respuesta !=2 && respuesta !=3;