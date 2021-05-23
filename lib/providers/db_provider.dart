import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path_provider/path_provider.dart';

import 'package:qr_reader/models/scan_model.dart';
/* En Cualquier Lugar Voy A Tener Una Sola Importación */
export 'package:qr_reader/models/scan_model.dart';

/* Patron Singleton, Para Que Me Funcione En Toda
  La Aplicación La Misma Instancia De Esta Clase
  De Base De Datos En Cualquier Parte Que Se
  Cree Dicha Instancia */
class DBProvider {

  /* Las TRES Siguientes Lineas De Código Son La Estructura De Un SINGLETON */
  static Database _database;
  /* Este Es Un Singleton Con El Constructor De Esta Clase Privado */
  static final DBProvider db = DBProvider._();
  /* Esto Me Ayuda Que Cuando Yo Haga Un New DBProvider Siempre Voy A Tener La Mismas
  Instancias De Esta Clase, Es Deci,  Los Objetos Estan Apuntando A Esta Misma Clase,
  En Conclusión Que Los Objetos Sean Los Mismos */
  DBProvider._();

  /* Aqui Estoy Accediendo A La Propiedad De Esta Clase, Que Anteriormente Se
  Asigno Como Privada */
  Future<Database> get database async {
    /* Si Ya Lo He Instanciado Anteriormente Quiero Que Me Devuelva La Misma Base De Datos */
    if (_database != null) return _database;

    /* Pero Si Por El Contrario, Es La Primera Vez, Me Va A Conectar Y A Entregar Una Base De 
       Datos */
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    /* Path Donde Almacenaremos La Base De Datos En El Dispositivo Movil (SQLite) */
    /* Si Se Elimina La Aplicación También Se Elimina El Archivo Donde Esta La Base De Datos */
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');

    print('Aqui Esta La Base De Datos En Nuestro Dispositivo => ' + path);

    /* Crear La Base De Datos */
    /* Se Debe Modificar La Version De La DB, Si Hacemos Cambios Estructurales,
    * Para Que Cree Las Tablas Nuevamente Y No Solo Abra La Base De Datos */
    return await openDatabase(path, version: 4, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      /* Estoy Definiendo Un String Multilinea Y Esto Es Propio De Dart (''') */
      await db.execute('''
        CREATE TABLE Scans(
          id INTEGER PRIMARY KEY,
          tipo TEXT,
          valor TEXT
        )
      ''');
    });
  }

  /* CON LA PALABRA RAW TENGO QUE ESPICIFICAR EL QUERY COMPLETO */
  /* Formas Para Ingresar Datos A La Base De Datos */
  /* FORMA #1 (FORMA LARGA) */
  Future<int> nuevoScanRaw(ScanModel nuevoScan) async {
    /* Aún No Tenemos La Desestructuración En Dart */
    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;

    /* Verificar Que La Base De Datos Esta Lista */
    /* database => Es Nuestro Getter Que Trabaja Con La Propiedad Privada _database */
    final db = await database;

    final res = await db.rawInsert(''' 
      INSERT INTO Scans(id, tipo, valor)
        VALUES($id, $tipo, $valor)
    ''');

    return res;
  }

  /* Formas Para Ingresar Datos A La Base De Datos */
  /* FORMA #2 (FORMA CORTA) */
  Future<int> nuevoScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.insert('Scans', nuevoScan.toJson());

    /* El ID Del Ultimo Registro Que Se Inserto En La Base De Datos */
    print(res);
    return res;
  }

  /* Formas Para Seleccionar Un Dato De La Base De Datos */
  Future<ScanModel> getScanById(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    /* Este Método(fromJson) Me Crea Una Nueva Instancia De La Clase ScanModel, Por Eso Es Tan Conveniente */
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  /* Formas Para Seleccionar TODOS Los Datos De La Base De Datos */
  Future<List<ScanModel>> getTodosScans() async {
    final db = await database;
    final res = await db.query('Scans');

    /* Lo Convierto En Una Lista, Por Que Es Un Iterable Y Necesito Retornar Una Lista */
    return res.isNotEmpty ? res.map((s) => ScanModel.fromJson(s)).toList() : [];
  }

  /* Formas Para Seleccionar TODOS Los Datos De La Base De Datos Por Tipo */
  Future<List<ScanModel>> getScansTipo(String tipo) async {
    final db = await database;
    final res = await db.rawQuery('''
      SELECT * FROM Scans WHERE tipo LIKE '%$tipo%'
    ''');

    return res.isNotEmpty ? res.map((s) => ScanModel.fromJson(s)).toList() : [];
  }

  /* Formas Para Actualizar Los Datos De La Base De Datos Por ID */
  Future<int> updateScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.update('Scans', nuevoScan.toJson(), where: 'id = ?', whereArgs: [nuevoScan.id]);
    return res;
  }

  /* Formas Para Eliminar Los Datos De La Base De Datos Por ID */
  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  /* Formas Para Eliminar TODOS Los Datos De La Base De Datos */
  Future<int> deleteAllScan() async {
    final db = await database;
    final res = await db.rawDelete('''
      DELETE FROM Scans
    ''');

    return res;
  }
}