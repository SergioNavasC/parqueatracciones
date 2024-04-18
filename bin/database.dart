import 'package:mysql1/mysql1.dart';

class Database {

  // Propiedades

  final String _host = 'localhost';
  final int _port = 3306;
  final String _user = 'root';

  // Métodos
  
  instalacion() async {
    var settings = ConnectionSettings(
      host: this._host, 
      port: this._port,
      user: this._user,
    );
    var conn = await MySqlConnection.connect(settings);
    try{
      await _crearDB(conn);
      //await _crearTablaUsuarios(conn);
      //await _crearTablaMascotas(conn);
      await conn.close();
    } catch(e){
      print(e);
      await conn.close();
    } 
  }

  Future<MySqlConnection> conexion() async {
    var settings = ConnectionSettings(
      host: this._host, 
      port: this._port,
      user: this._user,
      db: 'damdb'
    );
      
    return await MySqlConnection.connect(settings);
 
  }
  
  _crearDB (conn) async {
    await conn.query('CREATE DATABASE IF NOT EXISTS damdb');
    await conn.query('USE damdb');
    print('Conectado a damdb');
  }
}