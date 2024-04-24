
import 'package:mysql1/mysql1.dart';
import 'database.dart';

class Tarifa{

  //Propiedades 

  String? nombre;
  double? precio;
  String? detalles;

  //Constructores

  Tarifa();

  Tarifa.fromMap(ResultRow map){
    nombre = map["nombre"];
    precio = map["precio"];
    detalles = map["detalles"];
  }

  //Metodos

  insertarTarifas()async{
    var conn = await Database().conexion();
    try{
      await conn.query("INSERT INTO tarifas (nombre, precio, detalles) VALUES (?,?,?)", [nombre, precio, detalles]);
      print("Tarifa insertada correctamente");
    }catch(e){
      print(e);
    }finally{
      await conn.close();
    }
  }
}