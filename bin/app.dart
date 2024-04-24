import "dart:io";

import "tarifas.dart";
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
   menuLogin(Usuario usuario) async{
      int? respuesta;
      String? nombre = usuario.nombre;
      String? apellido = usuario.apellido;
      do {
          stdout.writeln(""" Bienvenido de nuevo $nombre $apellido, que desea hacer hoy? 
            1-Tipos de Tarifas
            2-Añadir metodos de pago
            3- Comprobar tipo de tarifa  
            4- Añadir Tarifas (solo admin)
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
        case 4:
           await addTarifas();
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
  addTarifas()async{
  
    Tarifa tarifa = new Tarifa();
    stdout.writeln("Escribe el nombre de la Tarifa");
    tarifa.nombre = stdin.readLineSync();
    stdout.writeln("Escribe el precio de la tarifa");
    tarifa.precio = parsearRespuestaDouble();
    stdout.writeln("Escribe los detalles sobre la tarifa");
    tarifa.detalles = stdin.readLineSync();
    await Tarifa().insertarTarifas();
    menuInicial();
    
  }
}
bool menuInicialRespuesta(var respuesta) => respuesta == null || respuesta !=1 && respuesta !=2;
int? parsearRespuesta() => int.tryParse(stdin.readLineSync() ?? 'e');
bool menuLoginRespuesta(var respuesta) => respuesta == null || respuesta !=1 && respuesta !=2 && respuesta !=3 && respuesta !=4;
double? parsearRespuestaDouble() => double.tryParse(stdin.readLineSync() ?? 'e');