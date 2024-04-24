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
      await _crearPQ(conn);
      await _crearTablaUsuarios(conn);
      await _crearTablaTarifas(conn);
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
      db: 'ParqueAtracciones'
    );
      
    return await MySqlConnection.connect(settings);
     
  }
  
  _crearPQ (conn) async {
    await conn.query('CREATE DATABASE IF NOT EXISTS ParqueAtracciones');
    await conn.query('USE ParqueAtracciones');
    print('Conectado a ParqueAtracciones');
  }
  _crearTablaUsuarios(conn) async {
        await conn.query('''CREATE TABLE IF NOT EXISTS usuarios(
        idusuario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(100) NOT NULL,
        apellido VARCHAR(100) NOT NULL,
        password VARCHAR(100) NOT NULL,
        dni VARCHAR(100) NOT NULL UNIQUE,
        correo VARCHAR(100) NOT NULL
    )''');
    print('Tabla usuarios creada');
  }
  _crearTablaTarifas(conn)async{
    await conn.query(""" CREATE TABLE IF NOT EXISTS tarifas(
      idtarifas INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
      nombre VARCHAR(100) NOT NULL UNIQUE,
      precio DOUBLE NOT NULL,
      detalles LONGTEXT NULL
    )
    """);
    print("Tabla tarifas creada");
  }
}